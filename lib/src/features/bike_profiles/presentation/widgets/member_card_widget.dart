import '../../../../src_export.dart';

class MemberCardWidget extends StatelessWidget {
  final String name;
  final String userId;  
  final String image;
  final String location;
  final String points;
  final String syndicateId;
  final String memberType;
  final String followers;

  const MemberCardWidget({
    super.key,
    required this.name,
    required this.image,
    required this.location,
    required this.points,
    required this.syndicateId,
    required this.memberType,
    required this.followers, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor, // matching the dark blue theme
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: ButtonTapWidget(
        radius: appRadius16,
        onTap: () {
          context.push(
            AppRoutes.memberDetails,
            extra: userId
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.kPrimaryColor, width: 2),
              ),
              child: CircleAvatar(backgroundImage: NetworkImage(image)),
            ),
            space8W,
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Name and Points
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.emoji_events,
                              size: 14,
                              color: Colors.white,
                            ),
                            space4W,
                            CustomText(
                              points,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  space8H,
                  // Middle Row: Badges
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomText(
                          syndicateId,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      space8W,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomText(
                            memberType,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  space8H,
                  // Bottom Row: Location and Followers
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 14,
                      ),
                      space4W,
                      Expanded(
                        child: CustomText(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.people_outline,
                        color: Colors.white,
                        size: 14,
                      ),
                      space4W,
                      CustomText(
                        followers,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
