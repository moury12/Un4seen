import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
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
  String? _selectedCountry = 'New Zealand';
  String? _selectedFit = 'Mens';
  String? _selectedTShirtSize = 'M';
  String? _selectedHoodieSize = 'M';

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

  @override
  Widget build(BuildContext context) {
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
                hintText: 'your.email@example.com',
                textEditingController: TextEditingController(),
                isRequired: false,
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.mobileNumber,
                hintText: '02-8312024',
                textEditingController: TextEditingController(),
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
              _buildDropdown(
                hint: 'Country',
                items: _countries,
                value: _selectedCountry,
                onChanged: (val) => setState(() => _selectedCountry = val),
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
                textEditingController: TextEditingController(),
              ),
              space8H,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.city,
                      textEditingController: TextEditingController(),
                    ),
                  ),
                  space8W,
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.postalCode,
                      textEditingController: TextEditingController(),
                    ),
                  ),
                ],
              ),
              space8H,
              CustomTextField(
                hintText: AppStaticStrings.stateRegion,
                textEditingController: TextEditingController(),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.clothingFit,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              _buildDropdown(
                hint: 'Fit',
                items: _fits,
                value: _selectedFit,
                onChanged: (val) => setState(() => _selectedFit = val),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.tshirtSize,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              _buildDropdown(
                hint: 'Size',
                items: _sizes,
                value: _selectedTShirtSize,
                onChanged: (val) => setState(() => _selectedTShirtSize = val),
              ),
              space8H,

              const CustomText(
                AppStaticStrings.hoodieJerseySize,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              _buildDropdown(
                hint: 'Size',
                items: _sizes,
                value: _selectedHoodieSize,
                onChanged: (val) => setState(() => _selectedHoodieSize = val),
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

              CustomButton(
                text: AppStaticStrings.next,
                onPressed: () {
                  context.push(AppRoutes.setupRide);
                },
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
