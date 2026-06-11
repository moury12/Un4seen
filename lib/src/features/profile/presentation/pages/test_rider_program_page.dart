import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../widgets/benefit_card_widget.dart';
import '../widgets/bullet_text_widget.dart';

class TestRiderProgramPage extends StatelessWidget {
  const TestRiderProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.testRiderProgram.tr)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppStaticStrings.bePartOfCreationProcess.tr,
                  style: const TextStyle(
                    color: AppColors.kSecondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.doYouWantToBecomeTestRider.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextColor,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.getEarlyAccessToNewProducts.tr,
                style: const TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.testThemInRealRidingConditions.tr,
                style: const TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.onceProductFullyDialed.tr,
                style: const TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.yourContentWillBeFeatured.tr,
                style: const TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.thisIsYourChanceToBePart.tr,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kTextColor,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.whatYouWillGet.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextColor,
                ),
              ),
              space8H,
              BenefitCardWidget(
                icon: AppIcons.stars,
                title: AppStaticStrings.earlyAccess.tr,
                subtitle: AppStaticStrings.beTheFirstToTest.tr,
              ),
              space8H,
              BenefitCardWidget(
                icon: AppIcons.cycle,
                title: AppStaticStrings.freeProducts.tr,
                subtitle: AppStaticStrings.keepTheFinishedVersions.tr,
              ),
              space8H,
              BenefitCardWidget(
                icon: AppIcons.camera,
                title: AppStaticStrings.featuredContent.tr,
                subtitle: AppStaticStrings.yourReviewsFeatured.tr,
              ),
              space8H,
              BenefitCardWidget(
                icon: AppIcons.groupPeople,
                title: AppStaticStrings.influenceDevelopment.tr,
                subtitle: AppStaticStrings.yourFeedbackDirectlyShapes.tr,
              ),
              space8H,
              Container(
                padding: AppPadding.getPadding12(context),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.kPrimaryColor,
                      AppColors.kPrimaryDarkColor,
                    ],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(appRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStaticStrings.applyNow.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kWhiteTextColor,
                      ),
                    ),
                    space8H,
                    CustomText(
                      AppStaticStrings.whyShouldYouBecomeTestRider.tr,
                      variant: TextVariant.labelMedium,
                      color: AppColors.kWhiteTextColor,
                    ),
                    space8H,
                    Container(
                      padding: AppPadding.getPadding12(context),
                      decoration: BoxDecoration(
                        color: AppColors.kSurfaceColor,
                        borderRadius: BorderRadius.circular(appRadius),
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            AppStaticStrings.tellUsAboutYourRidingExperience.tr,
                            variant: TextVariant.labelMedium,
                            color: AppColors.kTextColor,
                          ),
                          const CustomTextField(
                            maxLines: 3,
                            hintText: "",
                            borderColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    space8H,
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: AppStaticStrings.submitApplication.tr,
                        onPressed: () {},
                        icon: Icons.send,
                        // icon:  Icon(AppIcons.access,
                      ),
                    ),
                  ],
                ),
              ),
              space8H,
              Container(
                padding: AppPadding.getPadding12(context),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryDarkColor2,
                  borderRadius: BorderRadius.circular(appRadius),
                  border: Border.all(color: AppColors.kPrimaryDarkColor2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStaticStrings.whatWeAreLookingFor.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kWhiteTextColor,
                      ),
                    ),
                    space8H,
                    BulletTextWidget(
                      text: AppStaticStrings.activeRiderWhoLovesIt.tr,
                    ),
                    BulletTextWidget(
                      text:
                          AppStaticStrings.abilityToProvideDetailedFeedback.tr,
                    ),
                    BulletTextWidget(
                      text: AppStaticStrings.contentCreationSkills.tr,
                    ),
                    BulletTextWidget(
                      text: AppStaticStrings.socialMediaPresence.tr,
                    ),
                    BulletTextWidget(
                      text: AppStaticStrings.commitmentToTesting.tr,
                    ),
                    BulletTextWidget(
                      text: AppStaticStrings.passionForHelpingImprove.tr,
                    ),
                  ],
                ),
              ),
              space24H,
            ],
          ),
        ),
      ),
    );
  }
}
