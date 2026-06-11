import '../../../../src_export.dart';

class BuildsModsPage extends StatelessWidget {
  const BuildsModsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            const CustomText(
              'Kawasaki KLX140',
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              AppStaticStrings.buildsMods.tr,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          children: [
            CustomText(
              AppStaticStrings.shareYourBuildsDesc.tr,
              textAlign: TextAlign.center,
              fontSize: 12,
            ),
            space12H,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kPrimaryColor),
              ),
              child: Column(
                spacing: 8,
                children: [
                  const CustomTextField(
                    hintText: 'Share your build, mods, or questions...',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          borderRadius: 8,
                          text: AppStaticStrings.addPhoto.tr,
                          onPressed: () {},
                          icon: Icons.camera_alt_outlined,
                          isExpanding: true,
                          backgroundColor: AppColors.kPrimaryDarkColor2,
                        ),
                      ),
                      space8W,
                      Expanded(
                        child: CustomButton(
                          borderRadius: 8,
                          text: AppStaticStrings.post.tr,
                          onPressed: () {},
                          // icon: Icons.camera_alt_outlined,
                          isExpanding: true,
                          backgroundColor: AppColors.kPrimaryDarkColor2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            space16H,
            Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  Padding(
                    padding: AppPadding.getPadding12H(context).copyWith(top: 8),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?u=chris',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              'Chris Lee',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            CustomText(
                              '1 day ago',
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // --- Post Text ---
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CustomText(
                      'I just brought a 2024 klx140 what mods should i do. Whats the best exhaust?',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  space8H,

                  // --- Post Image ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const CustomNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=400',
                        height: 280,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Interaction Chips ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _interactionChip(Icons.thumb_up_alt_outlined, '42'),
                        const SizedBox(width: 10),
                        _interactionChip(Icons.chat_bubble_outline, '2'),
                        const SizedBox(width: 10),
                        _interactionChip(
                          Icons.share_outlined,
                          '',
                          isIconOnly: true,
                        ),
                      ],
                    ),
                  ),
                  space8H,

                  // --- Divider ---
                  Divider(color: Colors.white.withOpacity(0.3), height: 1),
                  space8H,

                  // --- Comments Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        _commentItem(
                          name: 'Mike Davis',
                          comment: 'That looks sick! Defo an FMF vibe!',
                          avatarUrl: 'https://i.pravatar.cc/150?u=mike',
                        ),
                        _commentItem(
                          name: 'Sarah Martinez',
                          comment: 'Love the color combo! Defo an FMF vibe 💯',
                          avatarUrl: 'https://i.pravatar.cc/150?u=sarah',
                        ),
                      ],
                    ),
                  ),

                  // --- Comment Input ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    child: Row(
                      spacing: 8,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?u=user',
                          ),
                        ),

                        Expanded(
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const CustomTextField(
                              hintText: 'Write a comment...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),

                              borderColor: Colors.transparent,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: AppColors.kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactionChip(
    IconData icon,
    String label, {
    bool isIconOnly = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.kPrimaryColor, size: 18),
          if (!isIconOnly) ...[
            const SizedBox(width: 6),
            CustomText(
              label,
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ],
        ],
      ),
    );
  }

  Widget _commentItem({
    required String name,
    required String comment,
    required String avatarUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(name, fontWeight: FontWeight.bold, fontSize: 13),
                  const SizedBox(height: 4),
                  CustomText(comment, fontSize: 12, color: Colors.black87),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
