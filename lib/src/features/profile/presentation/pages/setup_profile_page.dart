import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../controllers/profile_controller.dart';
import '../../../../core/routes/app_routes.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  // Dropdown states
  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;
  // Dummy lists
  final List<String> _days = List.generate(
    31,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );
  final List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final List<String> _years = List.generate(
    100,
    (index) => (DateTime.now().year - index).toString(),
  );
  final List<String> _countries = [
    'New Zealand',
    'Australia',
    'United States',
    'United Kingdom',
    'Canada',
  ];
  final List<String> _fits = ['Mens', 'Womens', 'Unisex'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'];

  late Worker _profileWorker;

  @override
  void initState() {
    super.initState();
    final ctrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    _parseDob(ctrl.userProfile.value.dob);

    _profileWorker = ever(ctrl.userProfile, (profile) {
      if (mounted) {
        setState(() {
          _parseDob(profile.dob);
        });
      }
    });
  }

  @override
  void dispose() {
    _profileWorker.dispose();
    super.dispose();
  }

  void _parseDob(String? dob) {
    if (dob == null || dob.isEmpty) return;
    try {
      final parts = dob.split('-');
      if (parts.length == 3) {
        final year = parts[0];
        final monthInt = int.tryParse(parts[1]);
        final dayInt = int.tryParse(parts[2]);

        if (year.isNotEmpty && _years.contains(year)) {
          _selectedYear = year;
        }
        if (monthInt != null && monthInt >= 1 && monthInt <= 12) {
          _selectedMonth = _months[monthInt - 1];
        }
        if (dayInt != null && dayInt >= 1 && dayInt <= 31) {
          final dayStr = dayInt.toString().padLeft(2, '0');
          if (_days.contains(dayStr)) {
            _selectedDay = dayStr;
          }
        }
      }
    } catch (e) {
      // ignore parsing errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kTextColor,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BikeProgressBar(progress: 0.5),
              space8H,
              const CustomText(
                AppStaticStrings.completeYourProfile,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.needDetailsRewards,
                variant: TextVariant.bodyMedium,
                color: AppColors.kSecondaryTextColor,
              ),
              space12H,

              const CustomText(
                AppStaticStrings.dateOfBirth,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Day',
                      items: _days,
                      value: _selectedDay,
                      onChanged: (val) => setState(() => _selectedDay = val),
                    ),
                  ),
                  space8W,
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Month',
                      items: _months,
                      value: _selectedMonth,
                      onChanged: (val) => setState(() => _selectedMonth = val),
                    ),
                  ),
                  space8W,
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Year',
                      items: _years,
                      value: _selectedYear,
                      onChanged: (val) => setState(() => _selectedYear = val),
                    ),
                  ),
                ],
              ),
              space4H,
              const CustomText(
                AppStaticStrings.dobWarning,
                variant: TextVariant.labelSmall,
                color: AppColors.kSecondaryTextColor,
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.emailAddress,
                textEditingController: ctrl.emailController,
                isRequired: false,
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.mobileNumber,
                textEditingController: ctrl.mobileController,
                isRequired: false,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('🇺🇸', style: TextStyle(fontSize: 18))],
                  ),
                ),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.country,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              Obx(
                () => _buildDropdown(
                  hint: 'Country',
                  items: _countries,
                  value: _countries.contains(ctrl.countryName.value)
                      ? ctrl.countryName.value
                      : null,
                  onChanged: (val) {
                    if (val != null) {
                      ctrl.countryName.value = val;
                    }
                  },
                ),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.deliveryAddress,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              CustomTextField(
                hintText: AppStaticStrings.streetAddress,
                textEditingController: ctrl.streetController,
              ),
              space8H,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.city,
                      textEditingController: ctrl.cityController,
                    ),
                  ),
                  space8W,
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.postalCode,
                      textEditingController: ctrl.zipController,
                    ),
                  ),
                ],
              ),
              space8H,
              CustomTextField(
                hintText: AppStaticStrings.stateRegion,
                textEditingController: ctrl.stateController,
              ),
              space8H,

              const CustomText(
                AppStaticStrings.clothingFit,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              Obx(
                () => _buildDropdown(
                  hint: 'Fit',
                  items: _fits,
                  value: _fits.contains(ctrl.selectedClothingFit.value)
                      ? ctrl.selectedClothingFit.value
                      : null,
                  onChanged: (val) {
                    if (val != null) {
                      ctrl.selectedClothingFit.value = val;
                    }
                  },
                ),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.tshirtSize,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              Obx(
                () => _buildDropdown(
                  hint: 'Size',
                  items: _sizes,
                  value: _sizes.contains(ctrl.selectedTShirtSize.value)
                      ? ctrl.selectedTShirtSize.value
                      : null,
                  onChanged: (val) {
                    if (val != null) {
                      ctrl.selectedTShirtSize.value = val;
                    }
                  },
                ),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.hoodieJerseySize,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              Obx(
                () => _buildDropdown(
                  hint: 'Size',
                  items: _sizes,
                  value: _sizes.contains(ctrl.selectedHoodieSize.value)
                      ? ctrl.selectedHoodieSize.value
                      : null,
                  onChanged: (val) {
                    if (val != null) {
                      ctrl.selectedHoodieSize.value = val;
                    }
                  },
                ),
              ),
              space8H,

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryDarkColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.kGoldColor,
                      size: 20,
                    ),
                    space8W,
                    const Expanded(
                      child: CustomText(
                        'Your date of birth is locked after submission and cannot be changed.',
                        variant: TextVariant.labelSmall,
                        color: AppColors.kWhiteTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              space8H,

              Obx(
                () => CustomButton(
                  text: AppStaticStrings.next,
                  isLoading: ctrl.isLoading.value,
                  onPressed: () {
                    if (_selectedDay == null ||
                        _selectedMonth == null ||
                        _selectedYear == null) {
                      CustomSnackbar.showError(
                        "Please select your Date of Birth",
                      );
                      return;
                    }

                    if (ctrl.countryName.value.isEmpty) {
                      CustomSnackbar.showError("Please select your country");
                      return;
                    }

                    final monthIndex = _months.indexOf(_selectedMonth!) + 1;
                    final monthStr = monthIndex.toString().padLeft(2, '0');
                    final dayStr = _selectedDay!.padLeft(2, '0');
                    final dobString = '$_selectedYear-$monthStr-$dayStr';

                    context.push(
                      AppRoutes.setupRide,
                      extra: {
                        "country": ctrl.countryName.value,
                        "dob": dobString,
                      },
                    );
                  },
                ),
              ),
              space24H,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: AppColors.kSecondaryTextColor,
              fontSize: 14,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.kSecondaryTextColor,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  color: AppColors.kTextColor,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
