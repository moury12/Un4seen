import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../widgets/member_card_widget.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final edgePadding = AppPadding.getPadding12(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.members.tr)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: edgePadding.copyWith(top: 0, bottom: 0),
              child: const CustomText(
                AppStaticStrings.discoverAndConnectWithTheSyndicate,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // 2. The TextField (Search Bar)
          SliverToBoxAdapter(
            child: Padding(
              padding: edgePadding,
              child: CustomTextField(
                hintText: 'Search members...'.tr,
                fillColor: AppColors.kPrimaryColor.withValues(alpha: .1),
                borderColor: AppColors.kPrimaryColor,
              ),
            ),
          ),

          // 3. The List of Members
          SliverPadding(
            padding: edgePadding.copyWith(top: 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return MemberCardWidget(
                  name: index == 0
                      ? 'Jake Thompson 🇺🇸'
                      : index == 1
                      ? 'Mike Davis 🇺🇸'
                      : 'Emma Wilson 🇺🇸',
                  location: 'Los Angeles, CA • BMX',
                  image: 'https://i.pravatar.cc/150?img=${index + 10}',
                  points: index == 0 ? '3890' : '5120',
                  syndicateId: '#SYN-2847',
                  memberType: AppStaticStrings.exclusiveSyndicateMember.tr,
                  followers: '342 ${AppStaticStrings.followers.tr}',
                );
              }, childCount: 4),
            ),
          ),
        ],
      ),
    );
  }
}
