import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/core_export.dart';
import '../widgets/idea_card_widget.dart';
import '../widgets/how_it_works_widget.dart';
import '../widgets/share_idea_dialog.dart';

class IdeasFeedbackPage extends StatelessWidget {
  const IdeasFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppColors.kTextColor),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CustomText(
              AppStaticStrings.ideasAndFeedback.tr,
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.kTextColor,
            ),
            CustomText(
              AppStaticStrings.helpShapeFuture.tr,
              variant: TextVariant.bodyMedium,
              color: AppColors.kSecondaryTextColor,
            ),  ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => ShareIdeaDialog.show(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            // Example data as per screenshot
            const IdeaCardWidget(
              icon: AppIcons.chat,
              title: 'Monthly Riding Meetups',
              description: 'Organize monthly local meetups for the Syndicate community to ride together',
              userName: 'Mike D',
              date: '4/23/2026',
              upvotes: 56,
              userImage: 'https://i.pravatar.cc/150?u=mike',
            ),
            const IdeaCardWidget(
              icon: AppIcons.cell,
              title: 'Make Decals for Cell Phones',
              description: 'Make custom decals for all models of cell phones',
              userName: 'Sarah',
              date: '4/25/2026',
              upvotes: 42,
              userImage: 'https://i.pravatar.cc/150?u=sarah',
            ),
            const IdeaCardWidget(
              icon: AppIcons.colorPlate,
              title: 'Make Custom Bar Pads',
              description: 'Make bar pads for dirtbikes that are customizable on the Un4seen website and then we can order',
              userName: 'Sarah',
              date: '4/25/2026',
              upvotes: 42,
              userImage: 'https://i.pravatar.cc/150?u=sarah2',
            ),
            const HowItWorksWidget(),
          ],
        ),
      ),
    );
  }
}
