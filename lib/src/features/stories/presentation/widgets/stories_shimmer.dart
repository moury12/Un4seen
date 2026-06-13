import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';
import 'story_card_custom_shape.dart';

class StoriesShimmer extends StatelessWidget {
  const StoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => GenericSlantedCard(
          isLeft: index % 2 == 0,
          child: Container(color: AppColors.kPrimaryDarkColor.withOpacity(0.2)),
        ),
        childCount: 6,
      ),
    );
  }
}