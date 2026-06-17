import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src_export.dart';
import 'stat_item_widget.dart';
import 'stat_divider_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String image;
  final String location;
  final String syndicateId;
  final String memberType;
  final String points;
  final String followers;
  final String following;
  final bool isCurrentUser;
 final bool isFollowing;
 final String? userId;
  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.image,
    required this.location,
    required this.syndicateId,
    required this.memberType,
    required this.points,
    required this.followers,
    required this.following,
    this.isCurrentUser = false,  this.isFollowing=false, this.userId,
  });

  @override
  Widget build(BuildContext context) {
        final controller = Get.find<ProfileController>();

    return Row(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Picture
        CustomNetworkImage(
          imageUrl: image,
          height: 80,
          width: 80,
          boxShape: BoxShape.circle,
        ),

        // Container(
        //   margin: const EdgeInsets.only(top: 20),
        //   width: 80,
        //   height: 80,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: Border.all(color: AppColors.kPrimaryColor, width: 2),
        //   ),
        //   child: CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
        // ),

        // Info Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name, Flag and Settings
              Row(
                spacing: 8,
                children: [
                  CustomText(
                    name,
                    fontSize: 18,
                    variant: TextVariant.headlineMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  // const CustomText('🇺🇸', fontSize: 16),
                  const Spacer(),
                  if (isCurrentUser)
                    ButtonTapWidget(
                      onTap: () => context.push(AppRoutes.settings),
                      radius: appRadius6,
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                ],
              ),
 if (!isCurrentUser) Row(spacing: 6,
   children: [
     Container(
                    padding: AppPadding.getPadding4(context),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.kPrimaryColor,
                          AppColors.kPrimaryDarkColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(appRadius6),
                    ),
                    child: ButtonTapWidget(
                      onTap: () {
                     
                          context.push(AppRoutes.channelMembers);
                        
                      },
                      radius: appRadius6,
                      child: Row(
                        spacing: 6,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                           AppIcons.chat ,
                            height: 15,
                          ),
                          CustomText(
                            AppStaticStrings.messageUn4seen.tr ,
                              
                            variant: TextVariant.labelSmall,
                            color: AppColors.kWhiteTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          if (!isCurrentUser) space4W,
                        ],
                      ),
                    ),
                  ),
  
   Container(
                padding: AppPadding.getPadding4(context),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.kPrimaryColor,
                      AppColors.kPrimaryDarkColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(appRadius6),
                ),
                child: ButtonTapWidget(
                  onTap: () {
                    if (isCurrentUser) {
                      context.push(AppRoutes.chat);
                    } else {
                                            controller.toggleFollow(controller.targetMemberDetails.value!);

                    }
                  },
                  radius: appRadius6,
                  child: Row(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        isCurrentUser ? AppIcons.chat : (isFollowing ? AppIcons.checked : AppIcons.addMember),
                        height: 15,
                      ),
                      CustomText(
                       isCurrentUser 
                          ? AppStaticStrings.messageUn4seen.tr 
                          : (isFollowing ? AppStaticStrings.unfollow.tr : AppStaticStrings.follow.tr),
                        variant: TextVariant.labelSmall,
                        color: AppColors.kWhiteTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      if (!isCurrentUser) space4W,
                    ],
                  ),
                ),
              ),
           ],
 ),
            

               if (!isCurrentUser)   space4H,

              // ID and Membership Pills
              Row(
                spacing: 6,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      syndicateId,
                      color: Colors.white,
                      variant: TextVariant.labelSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00A6FF), Color(0xFF0066CC)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      memberType,
                      color: Colors.white,
                      variant: TextVariant.labelSmall,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              space4H,

              // Location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.kTextColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  CustomText(location, variant: TextVariant.labelMedium),
                ],
              ),
              space4H,

              // Stats
              Row(
                spacing: 5,
                children: [
                  SvgPicture.asset(
                    AppIcons.pointsEarned,
                    height: 18,
                    width: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.kTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  StatItemWidget(
                    value: points,
                    label: AppStaticStrings.points.tr,
                  ),
                  const StatDividerWidget(),
                  // Inside build Stats Row
                  StatItemWidget(
                    value: followers,
                    label: AppStaticStrings.followers.tr,
                    onTap: ()  {
                      if (!isCurrentUser) {
                      controller.fetchOtherFollowers(userId!);
                    }
                      context.push(
                      AppRoutes.members,
                      extra: {
                        'title': AppStaticStrings.followers.tr,
                        'list':isCurrentUser? Get.find<ProfileController>().followersList : controller.userfollowersList,
                       'refresh': () => isCurrentUser 
                          ? controller.fetchFollowers() 
                          : controller.fetchOtherFollowers(userId!),
                      },
                    );}
                  ),
                  const StatDividerWidget(),
                  StatItemWidget(
                    value: following,
                    label: 'Following',
                    onTap: () { if (!isCurrentUser) {
                      controller.fetchOtherFollowing(userId!);
                    }
                      
                      context.push(

                      AppRoutes.members,
                      extra: {
                        'title': 'Following',
                         'list':  isCurrentUser ? controller.followingList : controller.userfollowingList,
                      'refresh': () => isCurrentUser 
                          ? controller.fetchFollowing() 
                          : controller.fetchOtherFollowing(userId!),
                      },
                    );}
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
