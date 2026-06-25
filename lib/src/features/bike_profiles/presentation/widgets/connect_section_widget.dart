import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core_export.dart';
import '../../../../core/utils/url_launcher_utils.dart';

class ConnectSectionWidget extends StatelessWidget {
  final Color bgColor;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? tiktokUrl;

  const ConnectSectionWidget({
    super.key,
    required this.bgColor,
    this.facebookUrl,
    this.instagramUrl,
    this.tiktokUrl,
  });

  String _formatUrl(String? urlOrUsername, String defaultUrl) {
    if (urlOrUsername == null ||
        urlOrUsername.trim().isEmpty ||
        urlOrUsername.trim() == '@username') {
      return defaultUrl;
    }
    final trimmed = urlOrUsername.trim();
    if (trimmed.startsWith("http://") || trimmed.startsWith("https://")) {
      return trimmed;
    }
    final cleanHandle = trimmed.startsWith('@')
        ? trimmed.substring(1)
        : trimmed;
    if (defaultUrl.contains("facebook.com")) {
      return "https://www.facebook.com/$cleanHandle";
    } else if (defaultUrl.contains("instagram.com")) {
      return "https://www.instagram.com/$cleanHandle";
    } else if (defaultUrl.contains("tiktok.com")) {
      return "https://www.tiktok.com/@$cleanHandle";
    }
    return defaultUrl;
  }

  @override
  Widget build(BuildContext context) {
    final fbLink = _formatUrl(facebookUrl, UrlLauncherUtils.facebookUrl);
    final igLink = _formatUrl(instagramUrl, UrlLauncherUtils.instagramUrl);
    final ttLink = _formatUrl(tiktokUrl, UrlLauncherUtils.tiktokUrl);

    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Connect",
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          space8H,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                _buildSocialButton(
                  AppIcons.fb,
                  "Facebook",
                  Colors.blue,
                  fbLink,
                ),
                _buildSocialButton(
                  AppIcons.ig,
                  "Instagram",
                  Colors.pink,
                  igLink,
                ),
                _buildSocialButton(
                  AppIcons.tictok,
                  "TikTok",
                  Colors.black,
                  ttLink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    String icon,
    String label,
    Color iconColor,
    String targetUrl,
  ) {
    return GestureDetector(
      onTap: () => UrlLauncherUtils.launchExternalUrl(targetUrl),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 6,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),

            const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
