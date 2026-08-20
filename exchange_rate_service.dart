import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Keeps a live-ish EUR to Naira rate, the way a money transfer app shows
/// "today's rate" on its home screen.
///
/// This is a market reference rate (European Central Bank, via a free,
/// no-key API), refreshed once per app session and cached locally so the
/// app still shows a number when offline. It is NOT the exact rate the
/// embassy or VFS applies on the day someone pays \u2014 they set their own
/// rate, which this app has no way to query. Every place this rate is shown
/// should make that difference clear rather than imply the two match.
class ExchangeRateService extends ChangeNotifier {
  static const _rateKey = 'eur_ngn_rate';
  static const _updatedKey = 'eur_ngn_rate_updated';

  /// Refetch at most this often, so the app is not hitting the API on
  /// every single launch.
  static const _minRefreshGap = Duration(hours: 6);

  SharedPreferences? _prefs;
  double? _rate;
  DateTime? _lastUpdated;
  bool _isLoading = false;
  bool _fetchFailed = false;

  double? get rate => _rate;
  DateTime? get lastUpdated => _lastUpdated;
  bool get isLoading => _isLoading;

  /// True once we have never successfully fetched a rate, even from cache.
  bool get hasNoRate => _rate == null;

  /// True if the last attempt to refresh failed and we are showing an
  /// older cached number instead.
  bool get isShowingCachedRate => _fetchFailed && _rate != null;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final cachedRate = _prefs?.getDouble(_rateKey);
    final cachedUpdatedMillis = _prefs?.getInt(_updatedKey);
    if (cachedRate != null) _rate = cachedRate;
    if (cachedUpdatedMillis != null) {
      _lastUpdated = DateTime.fromMillisecondsSinceEpoch(cachedUpdatedMillis);
    }
    notifyListeners();

    final dueForRefresh = _lastUpdated == null ||
        DateTime.now().difference(_lastUpdated!) > _minRefreshGap;
    if (dueForRefresh) {
      await refresh();
    }
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http
          .get(Uri.parse('https://api.frankfurter.app/latest?from=EUR&to=NGN'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final rates = data['rates'] as Map<String, dynamic>;
        final newRate = (rates['NGN'] as num).toDouble();

        _rate = newRate;
        _lastUpdated = DateTime.now();
        _fetchFailed = false;

        await _prefs?.setDouble(_rateKey, newRate);
        await _prefs?.setInt(
            _updatedKey, _lastUpdated!.millisecondsSinceEpoch);
      } else {
        _fetchFailed = true;
      }
    } catch (e) {
      _fetchFailed = true;
      debugPrint('ExchangeRateService refresh failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Converts a euro amount to a formatted Naira string, e.g. "\u20A61,453,200".
  /// Returns null if no rate is available yet (first launch, offline).
  String? nairaEquivalent(double eurAmount) {
    if (_rate == null) return null;
    final value = (eurAmount * _rate!).round();
    return '\u20A6${_thousands(value)}';
  }

  /// "1 EUR \u2248 \u20A61,780" for display near the rate itself.
  String? get rateLabel {
    if (_rate == null) return null;
    return '1 EUR \u2248 \u20A6${_thousands(_rate!.round())}';
  }

  /// A short human phrase like "Updated today" or "Updated 3 days ago".
  String get updatedLabel {
    if (_lastUpdated == null) return 'Not yet fetched';
    final diff = DateTime.now().difference(_lastUpdated!);
    if (diff.inHours < 1) return 'Updated just now';
    if (diff.inHours < 24) return 'Updated today';
    if (diff.inDays == 1) return 'Updated yesterday';
    return 'Updated ${diff.inDays} days ago';
  }

  static String _thousands(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return buffer.toString();
  }
}
