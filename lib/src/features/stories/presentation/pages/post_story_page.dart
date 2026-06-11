import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/music_selection_sheet.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/post_story_dropdown.dart';
import 'package:un4seen/src/src_export.dart';
import '../widgets/post_story_header.dart';
import '../widgets/post_story_image_upload.dart';

class PostStoryPage extends StatelessWidget {
  PostStoryPage({super.key});
  final List<String> musicOptions = [
    AppStaticStrings.noMusic.tr,
    AppStaticStrings.hyperBeat1.tr,
    AppStaticStrings.energyTrack.tr,
    AppStaticStrings.chillVibes.tr,
    AppStaticStrings.rockAnthem.tr,
  ];
  final List<String> categories = [
    AppStaticStrings.myStory.tr,
    AppStaticStrings.myRide.tr,
    AppStaticStrings.action.tr,
    AppStaticStrings.setup.tr,
    AppStaticStrings.event.tr,
  ];
  final List<String> filters = [
    AppStaticStrings.none.tr,
    AppStaticStrings.vintage.tr,
    AppStaticStrings.bw.tr,
    AppStaticStrings.cool.tr,
    AppStaticStrings.warm.tr,
    AppStaticStrings.vivid.tr,
    AppStaticStrings.fade.tr,
  ];
  final controller = Get.put(StoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              // Hide header when in image preview mode
              if (controller.selectedImage.value != null &&
                  !controller.isEditingDetails.value) {
                return const SizedBox.shrink();
              }
              return const Column(
                children: [
                  PostStoryHeader(),
                  Divider(color: AppColors.kPrimaryDarkColor, height: 1),
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                if (controller.selectedImage.value == null) {
                  return _buildImagePickerOptions();
                } else if (!controller.isEditingDetails.value) {
                  return _buildEditor(context);
                } else {
                  return _buildDetailsForm(context);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOptions() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_search,
              size: 80,
              color: AppColors.kPrimaryColor,
            ),
            space24H,
            const CustomText(
              "Select Image Source", // Should ideally be from AppStaticStrings, using hardcoded fallback if missing
              variant: TextVariant.titleLarge,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            space24H,
            space8H,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Camera",
                    icon: Icons.camera_alt,
                    onPressed: controller.pickImageFromCamera,
                    backgroundColor: AppColors.kPrimaryDarkColor,
                    textColor: Colors.white,
                  ),
                ),
                space16W,
                Expanded(
                  child: CustomButton(
                    text: "Gallery",
                    icon: Icons.photo_library,
                    onPressed: controller.pickImage,
                    backgroundColor: AppColors.kPrimaryDarkColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditor(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Full Image
              Positioned.fill(
                child: Image.file(
                  controller.selectedImage.value!,
                  fit: BoxFit.cover,
                ),
              ),
              // Top Left Back Button
              Positioned(
                top: 16,
                left: 16,
                child: _buildCircularIconButton(Icons.arrow_back_ios_new, () {
                  controller.selectedImage.value = null;
                }),
              ),
              // Top Right Tools
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    _buildCircularIconButton(Icons.text_fields, () {}),
                    space16H,
                    _buildCircularIconButton(
                      Icons.auto_awesome,
                      () => _showFilterSheet(context),
                    ),
                    space16H,
                    _buildCircularIconButton(
                      Icons.music_note,
                      () => _showMusicSheet(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: const Color(0xFF0B0B15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCircularIconButton(Icons.arrow_forward_ios, () {
                // controller.isEditingDetails.value = true;
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDarkColor3.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.kPrimaryDarkColor3,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                "Select Filter",
                variant: TextVariant.titleMedium,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              space24H,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: filters.map((filter) {
                      return ButtonTapWidget(
                        onTap: () {
                          controller.selectedFilter.value = filter;
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CustomText(
                            filter,
                            color: controller.selectedFilter.value == filter
                                ? AppColors.kPrimaryColor
                                : Colors.white,
                            fontWeight:
                                controller.selectedFilter.value == filter
                                ? FontWeight.bold
                                : FontWeight.normal,
                            variant: TextVariant.titleSmall,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              space24H,
            ],
          ),
        );
      },
    );
  }

  void _showMusicSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 0.8, // Make it large for better browsing
          child: MusicSelectionSheet(),
        );
      },
    );
  }
  Widget _buildDetailsForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostStoryImageUpload(),
          Obx(
            () => PostStoryDropdown(
              title: AppStaticStrings.category.tr,
              hintText: AppStaticStrings.selectACategory.tr,
              options: categories,
              selectedValue: controller.selectedCategory.value,
              onSelected: controller.setCategory,
            ),
          ),
          CustomTextField(
            title: AppStaticStrings.caption.tr,
            hintText: AppStaticStrings.addACaption.tr,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            fillColor: Colors.transparent,
            borderColor: AppColors.kPrimaryDarkColor,
            maxLines: 4,
          ),
          Obx(
            () => PostStoryDropdown(
              title: AppStaticStrings.addMusic.tr,
              hintText: AppStaticStrings.selectAMusic.tr,
              options: musicOptions,
              selectedValue: controller.selectedMusic.value,
              onSelected: controller.setMusic,
            ),
          ),
          CustomText(
            AppStaticStrings.filter.tr,
            fontWeight: FontWeight.bold,
            variant: TextVariant.titleMedium,
            color: AppColors.kWhiteTextColor,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Row(
                children: filters.map((filter) {
                  return ButtonTapWidget(
                    onTap: () {
                      controller.selectedFilter.value = filter;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CustomText(
                        filter,
                        color: controller.selectedFilter.value == filter
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                        fontWeight: controller.selectedFilter.value == filter
                            ? FontWeight.bold
                            : FontWeight.normal,
                        variant: TextVariant.labelMedium,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: AppPadding.getPadding12H(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.kPrimaryColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.zoom_in, color: Colors.white, size: 20),
                space8W,
                Expanded(
                  child: CustomText(
                    AppStaticStrings.autoZoomCrop.tr,
                    color: Colors.white,
                    variant: TextVariant.bodyMedium,
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Obx(
                    () => Checkbox(
                      value: controller.isAutoZoom.value,
                      onChanged: (v) {
                        if (v != null) {
                          controller.isAutoZoom.value = v;
                        }
                      },
                      activeColor: AppColors.kPrimaryColor,
                      checkColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomText(
            AppStaticStrings.autoCropZoomDesc.tr,
            color: Colors.white,
            variant: TextVariant.labelMedium,
          ),
          CustomButton(
            text: AppStaticStrings.postStory.tr,
            onPressed: () {},
            icon: Icons.file_upload_outlined,
            backgroundColor: AppColors.kPrimaryColor,
            textColor: Colors.white,
          ),
          CustomText(
            AppStaticStrings.storyVisibilityDesc.tr,
            color: Colors.white,
            variant: TextVariant.labelMedium,
            textAlign: TextAlign.center,
          ),
          space12H,
        ],
      ),
    );
  }
}
