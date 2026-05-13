import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/core_export.dart';

class StoryBottomBar extends StatelessWidget {
  final VoidCallback onJoinTap;
  final Function(String) onMessageSent;

  const StoryBottomBar({
    super.key,
    required this.onJoinTap,
    required this.onMessageSent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.getPadding12(context).copyWith(left: 20, bottom: 20),
      child: Row(
        spacing: 12,
        children: [
          CustomIconButtonWidget(image: AppIcons.fire),
          CustomIconButtonWidget(iconData: CupertinoIcons.bookmark),
          CustomIconButtonWidget(iconData: Icons.download_outlined),
        ],
      ),
    );
  }
}

class CustomIconButtonWidget extends StatelessWidget {
  final String? image;
  final IconData? iconData;
  final double? padding;
  final double? iconSize;
  final VoidCallback? onPressed;
  const CustomIconButtonWidget({
    super.key,
    this.image,
    this.padding,
    this.iconSize,
    this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onPressed,
      child: Container(
        padding:  EdgeInsets.all(padding??12),
      decoration: BoxDecoration(  
        shape: BoxShape.circle,
        color: AppColors.kPrimaryDarkColor3,
      ),
      child: image != null
          ? SvgPicture.asset(image!, height:   iconSize??30,width:iconSize??30,)
          : Icon(iconData, color: Colors.white, size: iconSize??30),
    ),
    );
  }
}
