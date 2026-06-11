import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  final int segmentCount;
  final int activeIndex;

  const StoryProgressBar({
    super.key,
    required this.segmentCount,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: List.generate(segmentCount, (index) {
          return Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index <= activeIndex
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          );
        }),
      ),
    );
  }
}
