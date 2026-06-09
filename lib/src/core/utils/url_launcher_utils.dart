import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_snackbar.dart';

class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<void> launchExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    
    try {
      // On iOS, sometimes canLaunchUrl returns false even if it can open.
      // We try to launch directly and catch the error.
      bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      
      if (!launched) {
        CustomSnackbar.showError("Could not open the link");
      }
    } catch (e) {
      // This catches the PlatformException and shows a user-friendly message
      CustomSnackbar.showError("Link unavailable or App not installed");
      print("UrlLauncher Error: $e");
    }
  }

  static const String facebookUrl = "https://www.facebook.com/un4seendecals";
  static const String instagramUrl = "https://www.instagram.com/un4seendecals";
  static const String tiktokUrl = "https://www.tiktok.com/@un4seendecals";
}