import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/profile/data/models/profile_model.dart';
import '../widgets/member_card_widget.dart';

class MembersPage extends StatelessWidget {
final String title;
  final RxList<ProfileModel> users;
  final Future<void> Function() onRefresh;

  const MembersPage({
    super.key,
    required this.title,
    required this.users,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final edgePadding = AppPadding.getPadding12(context);
    return Scaffold(
      appBar: AppBar(title: Text("$title ${AppStaticStrings.members.tr}")),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(() => CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if (users.isEmpty)
              SliverFillRemaining(
                child: Center(child: CustomText("No users found".tr, color: Colors.grey)),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final user = users[index];
                      return MemberCardWidget(
                        userId: user.id!,
                        name: user.fullName ?? "Unknown",
                        location: user.country ?? "",
                        image: user.profilePicture ?? "",
                        points: user.shredPoints.toString(),
                        syndicateId: user.memberNumber ?? "",
                        memberType: "Syndicate Member",
                        followers: user.followerCount.toString(),
                      );
                    },
                    childCount: users.length,
                  ),
                ),
              ),
          ],
        )),
      ),
      
      );
  }
}
