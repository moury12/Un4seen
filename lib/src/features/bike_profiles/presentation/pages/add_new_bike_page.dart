import 'package:flutter/foundation.dart';
import 'package:un4seen/src/features/bike_profiles/presentation/widgets/labeled_new_field.dart';

import '../../../../src_export.dart';
import '../widgets/image_upload_section.dart';

class AddNewBikePage extends StatefulWidget {
  final BikeModel? bikeToEdit;
  const AddNewBikePage({super.key, this.bikeToEdit});

  @override
  State<AddNewBikePage> createState() => _AddNewBikePageState();
}

class _AddNewBikePageState extends State<AddNewBikePage> {
  final _formKey = GlobalKey<FormState>();
  final yearCtrl = TextEditingController(text: kDebugMode ? "2024" : "");
  final makeCtrl = TextEditingController(text: kDebugMode ? "Honda" : "");
  final modelCtrl = TextEditingController(text: kDebugMode ? "CRF250R" : "");
  final typeCtrl = TextEditingController(text: kDebugMode ? "250R" : "");
  final colorCtrl = TextEditingController(text: kDebugMode ? "Red" : "");
  final bikeHoursCtrl = TextEditingController(text: kDebugMode ? "12.5" : "");
  final estimatedCostCtrl = TextEditingController(text: kDebugMode ? "2850" : "");
  final noteTitleCtrl = TextEditingController(
    text: kDebugMode ? "test Title" : "",
  );
  final notePointCtrl = TextEditingController(
    text: kDebugMode ? "test Point 1" : "",
  );

  @override
  void initState() {
    super.initState();
    if (widget.bikeToEdit != null) {
      final bike = widget.bikeToEdit!;
      yearCtrl.text = bike.year;
      makeCtrl.text = bike.make;
      modelCtrl.text = bike.model;
      typeCtrl.text = bike.bikeType;
      colorCtrl.text = bike.color;
      
      final controller = Get.find<BikeProfilesController>();
      // Pre-fill build notes (upgrades)
      if (bike.upgrades.isNotEmpty) {
        controller.buildNoteSets.clear();
        for (var upgrade in bike.upgrades) {
          final noteSet = BuildNoteSet();
          noteSet.titleController.text = upgrade.title;
          noteSet.pointControllers.clear();
          for (var item in upgrade.items) {
            noteSet.pointControllers.add(TextEditingController(text: item));
          }
          controller.buildNoteSets.add(noteSet);
        }
      }
    }else{
      final controller = Get.find<BikeProfilesController>();
      controller.buildNoteSets.clear();
      yearCtrl.clear();
      makeCtrl.clear();
      modelCtrl.clear();
      typeCtrl.clear();
      colorCtrl.clear();
      bikeHoursCtrl.clear();
      estimatedCostCtrl.clear();
      noteTitleCtrl.clear();
      notePointCtrl.clear();
      controller.buildNoteSets.add(BuildNoteSet());

    }
  }

  @override
  void dispose() {
    yearCtrl.dispose();
    makeCtrl.dispose();
    modelCtrl.dispose();
    typeCtrl.dispose();
    colorCtrl.dispose();
    bikeHoursCtrl.dispose();
    estimatedCostCtrl.dispose();
    noteTitleCtrl.dispose();
    notePointCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BikeProfilesController>();
    const Color scaffoldBg = AppColors.kPrimaryDarkColor3;
    const Color borderColor = AppColors.kPrimaryDarkColor; // Light Blue Border
    const Color noteBoxBg =
        AppColors.kPrimaryDarkColor2; // Lighter Blue for Note

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 24,
                  ),
                  space12W,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          widget.bikeToEdit != null ? AppStaticStrings.updateBike.tr : AppStaticStrings.addNewBike.tr,
                          variant: TextVariant.titleLarge,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        if (widget.bikeToEdit == null)
                          CustomText(
                            AppStaticStrings
                                .yourCurrentBikeWillBeMovedToRetiredBikes
                                .tr,
                            variant: TextVariant.labelSmall,
                            color: Colors.white.withOpacity(0.8),
                          ),
                      ],
                    ),
                  ),
                  // Circular Close Button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: borderColor, height: 1),

            // --- CONTENT SECTION ---
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Center(child: ImageUploadSection(initialImageUrl: widget.bikeToEdit?.image)),
                    LabeledInputField(
                      label: "Year",
                      hint: "e.g., 2024",
                      controller: yearCtrl,
                    ),

                    LabeledInputField(
                      label: "Make",
                      hint: "e.g., Honda",
                      controller: makeCtrl,
                    ),

                    LabeledInputField(
                      label: "Model",
                      hint: "e.g., CRF250R",
                      controller: modelCtrl,
                    ),

                    LabeledInputField(
                      label: "Bike Type",
                      hint: "type here..",
                      controller: typeCtrl,
                    ),

                    LabeledInputField(
                      label: "Color",
                      hint: "e.g., Red",
                      controller: colorCtrl,
                    ),

                    LabeledInputField(
                      label: "Bike Hours",
                      hint: "e.g., 12.5",
                      controller: bikeHoursCtrl,
                    ),

                    LabeledInputField(
                      label: "Estimated Cost",
                      hint: "e.g., 2850",
                      controller: estimatedCostCtrl,
                    ),
                    const CustomText(
                      "Build Note",
                      fontWeight: FontWeight.bold,
                      variant: TextVariant.titleMedium,
                      color: Colors.white,
                    ),

                    // --- DYNAMIC BUILD NOTES SECTION ---
                    Obx(
                      () => Column(
                        children: List.generate(controller.buildNoteSets.length, (
                          noteIdx,
                        ) {
                          final noteSet = controller.buildNoteSets[noteIdx];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white10),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: LabeledInputField(
                                        label: "Upgrade Category",
                                        hint: "e.g., Engine Mods",
                                        controller: noteSet.titleController,
                                      ),
                                    ),
                                    if (controller.buildNoteSets.length > 1)
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                        onPressed: () => controller.removeBuildNote(noteIdx),
                                      ),
                                  ],
                                ),
                                space12H,

                                // Loop through points for this specific note
                                Obx(
                                  () => Column(
                                    children: List.generate(
                                      noteSet.pointControllers.length,
                                      (pointIdx) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: LabeledInputField(
                                                  label:
                                                      "Upgrade ${pointIdx + 1} ",
                                                  hint: "e.g., Ported Head",
                                                  controller: noteSet
                                                      .pointControllers[pointIdx],
                                                ),
                                              ),
                                              if (noteSet.pointControllers.length > 1)
                                                IconButton(
                                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                                                  onPressed: () => controller.removePointFromNote(noteIdx, pointIdx),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // ADD POINT BUTTON (Button 2)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    onPressed: () =>
                                        controller.addPointToNote(noteIdx),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                    label: const CustomText(
                                      "Add Point",
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    // Outlined Add Build Note Button
                    CustomButton(
                      text: "Add Build Upgrades",
                      onPressed: () {
                        controller.addNewBuildNote();
                      },
                      isOutlined: true,
                      icon: Icons.add,
                      textColor: Colors.white,
                      borderColor: borderColor,
                    ),

                    if (widget.bikeToEdit == null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: noteBoxBg.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: const CustomText(
                          "Note: Your current bike will be automatically moved to the retired bikes section. You can add upgrades to this bike after creating it.",
                          color: Colors.white,
                          variant: TextVariant.labelSmall,
                        ),
                      ),

                    // --- MAIN ADD BIKE BUTTON ---
                    Obx(
                      () => CustomButton(
                        text: widget.bikeToEdit != null ? "Update Bike" : "Add Bike",
                        isLoading: controller.isLoading.value,
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            CustomSnackbar.showError("Please fill all required fields");
                            return;
                          }

                          final res = widget.bikeToEdit != null
                              ? await controller.updateBike(
                                  bikeId: widget.bikeToEdit!.id,
                                  year: yearCtrl.text.trim(),
                                  make: makeCtrl.text.trim(),
                                  model: modelCtrl.text.trim(),
                                  type: typeCtrl.text.trim(),
                                  color: colorCtrl.text.trim(),
                                  bikeHours: bikeHoursCtrl.text.trim(),
                                  estimatedCost: estimatedCostCtrl.text.trim(),
                                )
                              : await controller.addBike(
                                  year: yearCtrl.text.trim(),
                                  make: makeCtrl.text.trim(),
                                  model: modelCtrl.text.trim(),
                                  type: typeCtrl.text.trim(),
                                  color: colorCtrl.text.trim(),
                                  bikeHours: bikeHoursCtrl.text.trim(),
                                  estimatedCost: estimatedCostCtrl.text.trim(),
                                );
                          if (res) {
                            yearCtrl.clear();
                            makeCtrl.clear();
                            modelCtrl.clear();
                            typeCtrl.clear();
                            colorCtrl.clear();
                            bikeHoursCtrl.clear();
                            estimatedCostCtrl.clear();
                            controller.buildNoteSets.clear();
                            controller.buildNoteSets.add(BuildNoteSet());
                            context.pop();
                          }
                        },
                        icon: widget.bikeToEdit != null ? Icons.save : Icons.add,
                        backgroundColor: AppColors.kPrimaryColor,
                      ),
                    ),
                    space24H,
                  ],
                ),
              ),
            ),
        )],
          ),)
      );
   
  }
}
