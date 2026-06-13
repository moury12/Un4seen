import 'dart:developer';

import 'package:un4seen/src/features/stories/presentation/controllers/music_controller.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/category_selection_sheet.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/music_selection_sheet.dart';
import 'package:un4seen/src/src_export.dart';
import '../widgets/post_story_header.dart';
import 'package:flutter/foundation.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class PostStoryPage extends StatelessWidget {
  PostStoryPage({super.key});

  final controller = Get.put(StoryController());
  final musicController = Get.put(MusicController());

  /// Helper to open the Pro Image Editor
  /// [initialTab] allows us to jump straight to Text, Filter, or Paint modes
  void _openEditor(BuildContext context) {
    if (controller.selectedImage.value == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProImageEditor.file(
          controller.selectedImage.value!,

          callbacks: ProImageEditorCallbacks(
            onImageEditingComplete: (Uint8List bytes) async {
              await controller.updateImageFromBytes(bytes);
              if (context.mounted) Navigator.pop(context);
            },
            // Fix: Version 12.0.0 expects a function that matches the signature
            // onCloseEditor: () {
            //   Get.back();
            // },
          ),
          configs: const ProImageEditorConfigs(
            // Fix: In 12.0.0 it is initialEditorMode, not initialSubEditor
            // initialEditorMode: initialTab ?? EditorMode.main,
            // Fix: Design mode name changed
            designMode: ImageEditorDesignMode.material,

            // // Fix: Theme configuration
            // theme: (
            //   background: AppColors.kPrimaryDarkColor3,
            //   uiPrimaryColor: AppColors.kPrimaryColor,
            // ),

            // In 12.0.0, features are enabled by default or configured here:
            textEditor: const TextEditorConfigs(),
            filterEditor: const FilterEditorConfigs(),
            paintEditor: const PaintEditorConfigs(),
            cropRotateEditor: const CropRotateEditorConfigs(),
          ),
        ),
      ),
    );
  }

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
                  return const SizedBox.shrink();
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
              "Select Image Source",
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
              // Full Image Display
              Positioned.fill(
                child: GestureDetector(
                  onTap: () =>
                      _openEditor(context), // Tap image to open full editor
                  child: Image.file(
                    controller.selectedImage.value!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Top Left Back Button
              Positioned(
                top: 16,
                left: 16,
                child: Obx(() {
                  final bool isCurrentPlaying =
                      musicController.currentPlayingId.value ==
                      controller.selectedMusicId.value;
                  final bool isPlaying =
                      isCurrentPlaying && musicController.isPlaying.value;
                  return Row(
                    children: [
                      _buildCircularIconButton(Icons.arrow_back_ios_new, () {
                        controller.selectedImage.value = null;
                      }),
                      space12W,
                      if (controller.selectedMusicModel.value != null &&
                          controller.selectedMusicName.value.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryDarkColor3.withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              ButtonTapWidget(
                                onTap: () => musicController.playToggle(
                                  controller.selectedMusicModel.value!,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor.withOpacity(
                                      0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                              controller.selectedMusicName.value.isNotEmpty
                                  ? CustomText(
                                      "♪ ${controller.selectedMusicName.value}",
                                      variant: TextVariant.titleMedium,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      space12W,
                      if (controller.selectedCategory.value.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryDarkColor3.withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: CustomText(
                            "${controller.selectedCategory.value}",
                            variant: TextVariant.titleMedium,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  );
                }),
              ),
              // Top Right Editing Tools
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    // Text Tool
                    _buildCircularIconButton(Icons.text_fields, () {
                      _openEditor(context);
                    }),
                    space16H,
                    // Paint/Draw Tool
                    _buildCircularIconButton(Icons.edit, () {
                      _openEditor(context);
                    }),
                    space16H,
                    // Filter Tool
                    _buildCircularIconButton(
                      Icons.auto_awesome,
                      () => _openEditor(context),
                    ),
                    space16H,
                    // Crop Tool
                    _buildCircularIconButton(
                      Icons.crop,
                      () => _openEditor(context),
                    ),
                    space16H,
                    // Music Selection (Your existing sheet)
                    _buildCircularIconButton(
                      Icons.music_note,
                      () => _showMusicSheet(context),
                    ),

                    space16H,

                    // Category Selection
                    _buildCircularIconButton(
                      Icons.label,
                      () => _showCategorySheet(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom Bar - Proceed to Details
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: const Color(0xFF0B0B15),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.isLoading.value)
                  CustomText(
                    controller.loadingStatus.value,
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                const Spacer(),
                controller.isLoading.value
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : _buildCircularIconButton(
                        Icons.arrow_forward_ios,
                        () async {
                          bool success = await controller.createStory();
                          if (success) {
                            Navigator.pop(context);
                          }
                        },
                      ),
              ],
            ),
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

  void _showCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const CategorySelectionSheet(),
    );
  }

  void _showMusicSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 0.8,
          child: MusicSelectionSheet(),
        );
      },
    );
  }
}
