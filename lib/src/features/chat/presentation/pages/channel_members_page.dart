import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/custom_text.dart';
import '../widgets/channel_member_item_widget.dart';

class ChannelMembersPage extends StatelessWidget {
  const ChannelMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.kTextColor),
          onPressed: () => context.pop(),
        ),
        title: CustomText(
          AppStaticStrings.channels.tr,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(AppStaticStrings.currentMembers.tr, fontWeight: FontWeight.bold),
            space12H,
            const ChannelMemberItemWidget(name: "Chris Lee", isAdded: true, isAdmin: true),
            space8H,
            const ChannelMemberItemWidget(name: "Taylor Kim", isAdded: true),
            space12H,
            CustomText(AppStaticStrings.addMembers.tr, fontWeight: FontWeight.bold),
            space12H,
            const ChannelMemberItemWidget(name: "Alex Rivera", isAdded: false),
          ],
        ),
      ),
    );
  }
}
