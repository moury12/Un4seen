import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';
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
            const PostStoryHeader(),
            const Divider(color: AppColors.kPrimaryDarkColor, height: 1),
            Expanded(
              child: SingleChildScrollView(
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
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
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
                                  color:
                                      controller.selectedFilter.value == filter
                                      ? AppColors.kPrimaryColor
                                      : Colors.white,
                                  fontWeight:
                                      controller.selectedFilter.value == filter
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
                          Icon(Icons.zoom_in, color: Colors.white, size: 20),
                          space8W,
                          Expanded(
                            child: CustomText(
                              AppStaticStrings.autoZoomCrop.tr,
                              color: Colors.white,
                              variant: TextVariant.bodyMedium,
                            ),
                          ),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
