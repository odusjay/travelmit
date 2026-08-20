import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../data/referral_codes.dart';

/// Handles the one-time unlock purchase via RevenueCat, plus an optional
/// referral code that applies a discount and tags the purchase so you can
/// see who referred it.
///
/// SETUP BEFORE RELEASE:
/// 1. Create a RevenueCat account and a project.
/// 2. Create a NON-CONSUMABLE product in App Store Connect and a
///    ONE-TIME (managed) product in Google Play Console, at full price.
/// 3. For the referral discount, create a SECOND product in both stores
///    priced 20% lower, and add it to the same Offering in RevenueCat with
///    the package identifier set below (referralPackageId). Without this
///    second product, referral codes still tag the purchase for tracking,
///    but the price will not actually change.
/// 4. Create an Entitlement named exactly `fullAccess` and attach BOTH
///    products to it, so either one unlocks the app.
/// 5. Paste your public SDK keys below.
class PurchaseService extends ChangeNotifier {
  // TODO(founder): paste your RevenueCat public SDK keys.
  static const String _androidApiKey = 'goog_YOUR_KEY_HERE';
  static const String _iosApiKey = 'appl_YOUR_KEY_HERE';

  /// Must match the entitlement identifier configured in RevenueCat.
  static const String entitlementId = 'fullAccess';

  /// The package identifier for the discounted, referral-priced product,
  /// as set up in your RevenueCat Offering.
  static const String referralPackageId = 'referral_discount';

  bool _isUnlocked = false;
  bool _isLoading = false;
  String? _errorMessage;
  Offering? _offering;
  String? _referralCode;
  String? _referralFriendName;

  bool get isUnlocked => _isUnlocked;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Offering? get offering => _offering;
  String? get referralFriendName => _referralFriendName;
  bool get hasReferralDiscount => _referralFriendName != null;

  /// The package that will actually be purchased: the discounted one if a
  /// valid code is applied and that package exists, otherwise the default.
  Package? get _activePackage {
    final packages = _offering?.availablePackages ?? const [];
    if (_referralFriendName != null) {
      for (final pkg in packages) {
        if (pkg.identifier == referralPackageId) return pkg;
      }
    }
    return packages.firstOrNull;
  }

  /// Price string for display, e.g. "₦80,000" or "$9.99".
  /// RevenueCat returns it already localised to the user's store currency.
  String? get displayPrice => _activePackage?.storeProduct.priceString;

  Future<void> init() async {
    _setLoading(true);
    try {
      await Purchases.setLogLevel(LogLevel.warn);

      final config = defaultTargetPlatform == TargetPlatform.android
          ? PurchasesConfiguration(_androidApiKey)
          : PurchasesConfiguration(_iosApiKey);
      await Purchases.configure(config);

      await _refreshEntitlement();
      await _loadOffering();
    } catch (e) {
      _errorMessage = 'Could not connect to the store. '
          'You can still browse the free preview.';
      debugPrint('PurchaseService init failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadOffering() async {
    final offerings = await Purchases.getOfferings();
    _offering = offerings.current;
    notifyListeners();
  }

  Future<void> _refreshEntitlement() async {
    final info = await Purchases.getCustomerInfo();
    _isUnlocked = info.entitlements.active.containsKey(entitlementId);
    notifyListeners();
  }

  /// Checks a code against the list in referral_codes.dart. Returns true if
  /// it matched. On success, tags the RevenueCat customer with the code so
  /// it shows up against the purchase in your dashboard.
  Future<bool> applyReferralCode(String code) async {
    final trimmed = code.trim().toUpperCase();
    final match = referralCodes.entries
        .where((e) => e.key.toUpperCase() == trimmed)
        .firstOrNull;

    if (match == null) {
      _referralCode = null;
      _referralFriendName = null;
      notifyListeners();
      return false;
    }

    _referralCode = trimmed;
    _referralFriendName = match.value;
    notifyListeners();

    try {
      await Purchases.setAttributes({
        'referral_code': trimmed,
        'referred_by': match.value,
      });
    } catch (e) {
      debugPrint('Could not tag referral attribute: $e');
    }
    return true;
  }

  void clearReferralCode() {
    _referralCode = null;
    _referralFriendName = null;
    notifyListeners();
  }

  /// Returns true if the purchase succeeded.
  Future<bool> purchase() async {
    final pkg = _activePackage;
    if (pkg == null) {
      _errorMessage = 'No purchase option available right now.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;
    try {
      final result = await Purchases.purchasePackage(pkg);
      _isUnlocked =
          result.customerInfo.entitlements.active.containsKey(entitlementId);
      return _isUnlocked;
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code != PurchasesErrorCode.purchaseCancelledError) {
        _errorMessage = 'Purchase could not be completed. Please try again.';
      }
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Required by both app stores — users who reinstall must be able to
  /// restore what they already paid for.
  Future<bool> restore() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final info = await Purchases.restorePurchases();
      _isUnlocked = info.entitlements.active.containsKey(entitlementId);
      if (!_isUnlocked) {
        _errorMessage = 'No previous purchase found for this account.';
      }
      return _isUnlocked;
    } catch (e) {
      _errorMessage = 'Could not restore purchases.';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
