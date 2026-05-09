import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';

class SetupRidePage extends StatefulWidget {
  const SetupRidePage({super.key});

  @override
  State<SetupRidePage> createState() => _SetupRidePageState();
}

class _SetupRidePageState extends State<SetupRidePage> {
  final List<String> _selectedRideTypes = ['MX', 'Enduro', 'E-Bike'];
  String _selectedRidingLevel = 'Beginner';

  final List<String> _rideTypes = [
    'MX',
    'Enduro',
    'E-Bike',
    'Surron/Up',
    'Go-Kart',
    'Road',
    'Harley/Cruiser',
    'ATV',
    'Vintage',
    'Adventure/Dual sport',
  ];
  final List<String> _ridingLevels = [
    'Beginner',
    'Intermediate',
    'Recreational',
    'Advanced',
    'Pro',
    'Hobby',
  ];

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
         const BikeProgressBar(progress: 1.0),
          

              space8H,
              const CustomText(
                AppStaticStrings.tellUsAboutYourRide,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space12H,

              const CustomText(
                AppStaticStrings.rideType,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space4H,
              const CustomText(
                AppStaticStrings.rideTypeDesc,
                variant: TextVariant.labelSmall,
                color: AppColors.kSecondaryTextColor,
              ),
              space8H,

              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: _rideTypes.map((type) {
                  final isSelected = _selectedRideTypes.contains(type);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedRideTypes.remove(type);
                        } else {
                          _selectedRideTypes.add(type);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.kPrimaryColor
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.kSecondaryTextColor,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              space12H,

              const CustomText(
                AppStaticStrings.ridingLevel,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,

              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: _ridingLevels.map((level) {
                  final isSelected = _selectedRidingLevel == level;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRidingLevel = level;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.kPrimaryColor
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.kSecondaryTextColor,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              space12H,

              CustomTextField(
                title: AppStaticStrings.bikeModel,
                hintText: 'Eg: Yamaha Yz450f',
                textEditingController: TextEditingController(),
                isRequired: false,
              ),
              space8H,

              CustomTextField(
                title: AppStaticStrings.year,
                hintText: 'Eg: 2024',
                textEditingController: TextEditingController(),
                isRequired: false,
              ),
              space12H,

              // const SizedBox(height: 32),
              CustomButton(
                text: AppStaticStrings.completeSetup,
                onPressed: () {
                  context.go(AppRoutes.home);
                },
              ),
              space12H,
            ],
          ),
        ),
      ),
    );
  }
}
