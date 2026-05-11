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
                  style: TextStyle(
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
                style: TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.testThemInRealRidingConditions.tr,
                style: TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.onceProductFullyDialed.tr,
                style: TextStyle(
                  color: AppColors.kSecondaryTextColor,
                  fontSize: 12,
                ),
              ),
              space8H,
              CustomText(
                AppStaticStrings.yourContentWillBeFeatured.tr,
                style: TextStyle(
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
                  color: AppColors.kPrimaryColor,
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
                        color: AppColors.kTextColor,
                      ),
                    ),
                    space8H,
                    CustomText(
                      AppStaticStrings.whyShouldYouBecomeTestRider.tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.kTextColor.withValues(alpha: 0.9),
                      ),
                    ),
                    space8H,
                    Container(
                      padding: AppPadding.getPadding12(context),
                      decoration: BoxDecoration(
                        color: AppColors.kSurfaceColor,
                        borderRadius: BorderRadius.circular(appRadius),
                      ),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: AppStaticStrings
                              .tellUsAboutYourRidingExperience
                              .tr,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.kSecondaryTextColor,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    space8H,
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: AppStaticStrings.submitApplication.tr,
                        onPressed: () {},
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
                  color: AppColors.kSurfaceColor,
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
                        color: AppColors.kTextColor,
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
