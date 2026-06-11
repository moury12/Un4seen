import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../../../../core/utils/filter_utils.dart';
import '../controllers/story_controller.dart';
import '../widgets/post_story_dropdown.dart';
import '../widgets/music_selection_sheet.dart';
import '../widgets/post_story_header.dart';

class PostStoryPage extends StatelessWidget {
  PostStoryPage({super.key});

  final controller = Get.put(StoryController());

  final List<String> categories = ['Bikes', 'Orders', 'Installs', 'Winners', 'Behind Scenes'];
  final List<String> filters = ["None", "Vintage", "B&W", "Warm", "Cool"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryDarkColor3,
      body: SafeArea(
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
    );
  }

  // STEP 1: Image Source Selection
  Widget _buildImagePickerOptions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_search, size: 80, color: AppColors.kPrimaryColor),
          space24H,
          const CustomText("Select Image Source", variant: TextVariant.titleLarge, color: Colors.white, fontWeight: FontWeight.bold),
          space24H,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(child: CustomButton(text: "Camera", icon: Icons.camera_alt, onPressed: controller.pickImageFromCamera)),
                space16W,
                Expanded(child: CustomButton(text: "Gallery", icon: Icons.photo_library, onPressed: controller.pickImage)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STEP 2: The Editor (Text + Filters)
  Widget _buildEditor(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // This boundary captures only the content inside it
              RepaintBoundary(
                key: controller.boundaryKey,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Obx(() => ColorFiltered(
                        colorFilter: FilterUtils.getFilter(controller.selectedFilter.value),
                        child: Image.file(controller.selectedImage.value!, fit: BoxFit.cover),
                      )),
                    ),
                    // Draggable Text Overlays
                    Obx(() => Stack(
                      children: controller.textOverlays.asMap().entries.map((entry) {
                        final item = entry.value;
                        return Positioned(
                          left: item.position.dx,
                          top: item.position.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) => controller.updateTextPosition(entry.key, item.position + details.delta),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                              child: CustomText(item.text, color: item.color, fontSize: item.fontSize, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
              // Tools Overlay (Outside Boundary)
              Positioned(
                top: 16, right: 16,
                child: Column(
                  children: [
                    _toolIcon(Icons.text_fields, () => _showTextDialog(context)),
                    space16H,
                    _toolIcon(Icons.auto_awesome, () => _showFilterSheet(context)),
                    space16H,
                    _toolIcon(Icons.music_note, () => _showMusicSheet(context)),
                  ],
                ),
              ),
              Positioned(top: 16, left: 16, child: _toolIcon(Icons.close, () => controller.selectedImage.value = null)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            
              SizedBox(width: 100,
                child: CustomButton(text: "Next", isExpanding: false,
                  onPressed: () => controller.isEditingDetails.value = true),
              ),
            ],
          ),
        )
      ],
    );
  }

  // STEP 3: Details Form
  Widget _buildDetailsForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostStoryHeader(),
          space24H,
          PostStoryDropdown(
            title: "Category",
            hintText: "Select category",
            options: categories,
            selectedValue: controller.selectedCategory.value,
            onSelected: (val) => controller.selectedCategory.value = val,
          ),
          space16H,
          CustomTextField(
            title: "Caption",
            hintText: "Write a caption...",
            textEditingController: controller.captionController,
            fillColor: Colors.transparent,
            maxLines: 3,
            titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          space24H,
          Obx(() => CustomButton(
            text: controller.isLoading.value ? controller.loadingStatus.value : "Post Story",
            isLoading: controller.isLoading.value,
            onPressed: controller.createStory,
          )),
        ],
      ),
    );
  }

  Widget _toolIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  void _showTextDialog(BuildContext context) {
    final textCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kPrimaryDarkColor3,
        title: const Text("Add Text", style: TextStyle(color: Colors.white)),
        content: CustomTextField(textEditingController: textCtrl,),
        actions: [
          CustomButton(text: "Add", onPressed: () {
            controller.addText(textCtrl.text);
            Navigator.pop(context);
          })
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kPrimaryDarkColor3,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: filters.map((f) => ListTile(
            title: CustomText(f, color: Colors.white),
            onTap: () {
              controller.selectedFilter.value = f;
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showMusicSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(heightFactor: 0.8, child: MusicSelectionSheet()),
    );
  }
}