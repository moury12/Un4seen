import 'package:cached_network_image/cached_network_image.dart';
import 'package:un4seen/src/features/chat/presentation/controller/builds_mods_controller.dart';
import '../../../../src_export.dart';
import '../../data/models/post_model.dart';

class BuildsModsPage extends StatelessWidget {
  final String channelId;
  final String channelName;
  const BuildsModsPage({
    super.key,
    required this.channelId,
    required this.channelName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      BuildsModsController(channelId: channelId),
      tag: channelId,
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CustomText(
              channelName,
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
      body: RefreshIndicator(
        onRefresh: () => controller.fetchFeed(isRefresh: true),
        color: AppColors.kPrimaryColor,
        child: SingleChildScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppPadding.getPadding12H(context),
          child: Column(
            children: [
              CustomText(
                AppStaticStrings.shareYourBuildsDesc.tr,
                textAlign: TextAlign.center,
                fontSize: 12,
              ),
              space12H,

              // --- Post Creation Box ---
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
                    CustomTextField(
                      textEditingController: controller.postTextController,
                      hintText: 'Share your build, mods, or questions...',
                    ),

                    // Reactive Image Selection Preview Layout
                    Obx(() {
                      if (controller.rxImageFile.value != null) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                controller.rxImageFile.value!,
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: GestureDetector(
                                onTap: () =>
                                    controller.rxImageFile.value = null,
                                child: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black54,
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),

                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            borderRadius: 8,
                            text: AppStaticStrings.addPhoto.tr,
                            onPressed: () => controller.pickPostImage(),
                            icon: Icons.camera_alt_outlined,
                            isExpanding: true,
                            backgroundColor: AppColors.kPrimaryDarkColor2,
                          ),
                        ),
                        space8W,
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              isLoading: controller.isSubmittingPost.value,
                              borderRadius: 8,
                              text: controller.isSubmittingPost.value
                                  ? 'Posting...'
                                  : AppStaticStrings.post.tr,
                              onPressed: () => controller.createPost(),
                              isExpanding: true,
                              backgroundColor: AppColors.kPrimaryDarkColor2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              space16H,

              // --- Dynamic Post Streams Feed Section ---
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  );
                }

                if (controller.posts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(
                            Icons.feed_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          space8H,
                          const CustomText(
                            'No posts in this build feed yet.\nBe the first to share something!',
                            textAlign: TextAlign.center,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      controller.posts.length +
                      (controller.isFetchingMore.value ? 1 : 0),
                  separatorBuilder: (_, __) => space16H,
                  itemBuilder: (context, index) {
                    if (index == controller.posts.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      );
                    }
                    return _buildPostCardItem(
                      context,
                      controller,
                      controller.posts[index],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCardItem(
    BuildContext context,
    BuildsModsController controller,
    PostModel post,
  ) {
    final commentFieldController = controller.getCommentController(post.id);
    final profileController = Get.find<ProfileController>();
    return Container(
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
                CircleAvatar(
                  radius: 22,
                  backgroundImage:
                      post.user.image != null && post.user.image!.isNotEmpty
                      ? NetworkImage(post.user.image!)
                      : const NetworkImage(
                          'https://i.pravatar.cc/150?u=fallback',
                        ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      post.user.fullName,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    CustomText(
                      post.timeAgo,
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          space8H,

          // --- Post Text ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomText(post.text, color: Colors.white, fontSize: 13),
          ),
          space8H,

          // --- Post Image ---
          if (post.image != null && post.image!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomNetworkImage(
                  imageUrl: post.image!,
                  height: 280,
                  width: double.infinity,
                ),
              ),
            ),
            space8H,
          ],

          // --- Interaction Chips ---
          // --- Interaction Chips Row inside _buildPostCardItem ---
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.toggleLike(post.id),
                    child: _interactionChip(
                      post.isLiked.value
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                      '${post.likeCount.value}',
                      iconColor: post.isLiked.value
                          ? Colors.blue.shade300
                          : AppColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _interactionChip(
                    Icons.chat_bubble_outline,
                    '${post.recentComments.length}',
                  ),
                  // const SizedBox(width: 10),
                  // _interactionChip(Icons.share_outlined, '', isIconOnly: true),
                ],
              ),
            ),
          ),
          space8H,

          // --- Divider ---
          Divider(color: Colors.white.withOpacity(0.3), height: 1),
          space8H,

          // --- Dynamic Comments List Section ---
          if (post.recentComments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: post.recentComments.length,
                itemBuilder: (context, cIndex) {
                  final comment = post.recentComments[cIndex];
                  return _commentItem(
                    name: comment.user.fullName,
                    comment: comment.text,
                    avatarUrl:
                        comment.user.image ??
                        'https://i.pravatar.cc/150?u=fallback',
                  );
                },
              ),
            ),

          // --- Comment Input Row Layout ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              spacing: 8,
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 18,
                    backgroundImage: CachedNetworkImageProvider(
                      profileController.userProfile.value.profilePicture ?? '',
                    ),
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
                    child: CustomTextField(
                      textEditingController: commentFieldController,
                      hintText: 'Write a comment...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      borderColor: Colors.transparent,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.addComment(post.id),
                  child: Container(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _interactionChip(
    IconData icon,
    String label, {
    bool isIconOnly = false,
    Color iconColor = AppColors.kPrimaryColor,
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
          Icon(icon, color: iconColor, size: 18),
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
          CircleAvatar(
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(avatarUrl),
          ),
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
