import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/gradient_container.dart';
import '../../../../src_export.dart';

class ReferAndEarnPage extends StatelessWidget {
  const ReferAndEarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCtrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: Text(
                AppStaticStrings.referAndEarn.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            SliverPadding(
              padding: AppPadding.getPadding12(context),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const CustomText(
                    'Share the Syndicate. Get rewarded.',
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  space12H,
                  GradientContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.stars,
                              color: Colors.white,
                              size: 20,
                            ),
                            space8W,
                            CustomText(
                              AppStaticStrings.myReferralCode.tr,
                              color: Colors.white,
                              variant: TextVariant.titleSmall,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        space12H,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Obx(
                                  () => CustomText(
                                    profileCtrl
                                            .userProfile
                                            .value
                                            .referralCode ??
                                        "no referral code",

                                    variant: TextVariant.titleSmall,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ),
                            ),
                            space12W,
                            GestureDetector(
                              onTap: () {
                                final code =
                                    profileCtrl.userProfile.value.referralCode;
                                if (code != null && code.isNotEmpty) {
                                  ClipboardUtils.copyText(code);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.copy,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Inside the ReferAndEarnPage build method, find the "Enter code" section and update it:
                        space16H,
                        CustomText(
                          AppStaticStrings.applyReferral.tr,
                          color: Colors.white,
                          variant: TextVariant.labelMedium,
                        ),
                        space8H,
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: "Enter code",
                                textEditingController:
                                    profileCtrl.referralInputController,
                              ),
                            ),
                            space12W,
                            Obx(
                              () => GestureDetector(
                                onTap: profileCtrl.isLoading.value
                                    ? null
                                    : () => profileCtrl.applyReferral(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: profileCtrl.isLoading.value
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : CustomText(
                                          AppStaticStrings.submit.tr,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  space24H,
                  GradientContainer(
                    borderRadius: 16,
                    padding: AppPadding.getPadding16(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          AppStaticStrings.howReferralsWork.tr,
                          variant: TextVariant.titleMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        space16H,
                        _buildStep(
                          context,
                          '1',
                          AppStaticStrings.shareYourCode.tr,
                          'Send your unique referral code to friends',
                        ),
                        space12H,
                        _buildStep(
                          context,
                          '2',
                          AppStaticStrings.theySignUp.tr,
                          'Your friend creates an account using your code',
                        ),
                        space12H,
                        _buildStep(
                          context,
                          '3',
                          AppStaticStrings.youEarnPoints.tr,
                          'You get \$10 NZD store credit instantly',
                        ),
                      ],
                    ),
                  ),
                  space16H,
                  const Center(
                    child: CustomText(
                      'Pro tip: The more you share, the more you earn no limit!',
                      textAlign: TextAlign.center,
                      variant: TextVariant.labelSmall,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    String number,
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: CustomText(
            number,
            color: AppColors.kPrimaryColor,
            variant: TextVariant.labelMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
        space12W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                variant: TextVariant.labelLarge,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              CustomText(
                subtitle,
                variant: TextVariant.labelSmall,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
