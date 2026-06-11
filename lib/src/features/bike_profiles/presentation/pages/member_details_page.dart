import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/profile_header_widget.dart';
import '../../../../core/core_export.dart';
import '../widgets/syndicate_journey_widget.dart';
import '../widgets/about_me_widget.dart';
import '../widgets/connect_section_widget.dart';
import '../widgets/bike_profile_tile_widget.dart';

class MemberDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String location;
  final String syndicateId;
  final String memberType;
  final String points;
  final String followers;
  final String following;

  const MemberDetailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.location,
    required this.syndicateId,
    required this.memberType,
    required this.points,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on the provided image
    const Color cardBg = AppColors.kPrimaryDarkColor3; // Deep Navy/Teal
    const Color highlightBlue = AppColors.kPrimaryColor;

    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.details.tr)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderWidget(
                name: name,
                image: image,
                location: location,
                syndicateId: syndicateId,
                memberType: memberType,
                points: points,
                followers: followers,
                following: following,
                isCurrentUser: false,
              ),
              space8H,

              // --- SYNDICATE JOURNEY SECTION ---
              const SyndicateJourneyWidget(
                bgColor: cardBg,
                accentColor: highlightBlue,
              ),
              space8H,

              // --- ABOUT ME SECTION ---
              const AboutMeWidget(bgColor: cardBg),
              space8H,

              // --- CONNECT SECTION ---
              const ConnectSectionWidget(bgColor: cardBg),
              space8H,

              // --- BIKE PROFILE SECTION ---
              const BikeProfileTileWidget(
                bgColor: cardBg,
                accentColor: highlightBlue,
              ),
              space8H,
            ],
          ),
        ),
      ),
    );
  }
}
