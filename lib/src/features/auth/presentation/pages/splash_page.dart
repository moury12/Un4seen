import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core_export.dart';
import '../../../../core/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> logoMove;
  late Animation<double> bgFade;
  late Animation<double> uiFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    /// Logo movement (whole duration)
    logoMove = Tween<double>(
      begin: 0.0,
      end: -0.35,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    /// Background fade OUT
    bgFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
      ),
    );

    /// New UI fade IN
    uiFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    /// Optional navigation
    // _controller.forward().whenComplete(() {
    //   context.go(AppRoutes.home);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              /// 🔽 BACKGROUND IMAGE (fade out)
              Opacity(
                opacity: bgFade.value,
                child: SizedBox.expand(
                  child: Image.asset(
                    AppImages.bgImg, // your first image
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 🔽 NEW UI (fade in)
              Opacity(
                opacity: uiFade.value,
                child: Center(
                  child: Padding(
                    padding: AppPadding.getPadding12(context),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 85),
                          Image.asset(
                            AppImages.splash,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          CustomText(
                            AppStaticStrings.thisIsWhereRidersGetRewarded,
                            variant: TextVariant.displaySmall,
                          ),
                          CustomText(
                            AppStaticStrings
                                .theExclusiveWorldwideMotorcycleCommunityBuiltForRidersByRiders,
                            variant: TextVariant.labelSmall,
                            color: AppColors.kSecondaryTextColor,
                          ),
                          CustomButton(
                            text: AppStaticStrings.getStarted,
                            onPressed: () {
                              context.go(AppRoutes.login);
                            },
                          ),
                          CustomText(
                            AppStaticStrings
                                .byContinuingYouAgreeToOurTermsOfServiceAndPrivacyPolicy,
                            variant: TextVariant.labelSmall,
                            color: AppColors.kSecondaryTextColor,
                            textAlign: TextAlign.center,
                          ),
                          CustomText(
                            AppStaticStrings.rideShareEarnWin,
                            variant: TextVariant.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔼 LOGO (always on top + moves)
              Transform.translate(
                offset: Offset(0, logoMove.value * size.height),
                child: Center(child: Image.asset(AppImages.logo, height: 85)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
