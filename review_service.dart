import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sends people to the store listing to leave a rating.
///
/// Fill in the two ids below once the app is registered with each store.
/// Until then the buttons stay hidden rather than opening a dead link.
class ReviewService {
  /// From App Store Connect, the numeric id in your app's URL.
  static const String appStoreId = '';

  /// Your Android package name, e.g. com.yourname.travelmit
  static const String playStorePackage = '';

  static bool get isConfigured =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? appStoreId.isNotEmpty
          : playStorePackage.isNotEmpty;

  static Future<void> openStoreListing() async {
    final url = defaultTargetPlatform == TargetPlatform.iOS
        ? 'https://apps.apple.com/app/id$appStoreId?action=write-review'
        : 'https://play.google.com/store/apps/details?id=$playStorePackage';

    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
