import 'package:flutter/material.dart';
import 'package:un4seen/src/features/stories/presentation/stories_presentation_export.dart';
import '../../../../core/core_export.dart';

class StoryUserInfo extends StatelessWidget {
  final String name;
  final String time;
  final String image;

  const StoryUserInfo({
    super.key,
    required this.name,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundImage: NetworkImage(image)),
          space8W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildBadgeWidget(name, context),
              const SizedBox(height: 4),
              buildBadgeWidget(time, context),
            ],
          ),
        ],
      ),
    );
  }
}
