import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/dynamic_tab_widget.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/announcements_button.dart';
import 'package:un4seen/src/features/stories/presentation/widgets/filter_chip_widget.dart';

class StoryFilterChips extends StatelessWidget {
  const StoryFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      AppStaticStrings.all.tr,
      AppStaticStrings.unseen.tr,
      AppStaticStrings.seen.tr,
      AppStaticStrings.friends.tr,
    ];
    List<Widget> tabContent = [
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ];
    return Row(
      children: [
        Expanded(
          child: DynamicTabWidget(tabs: tabs, tabContent: tabContent),
          // child: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          //   decoration: BoxDecoration(
          //     color: AppColors.kPrimaryColor.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(25),
          //   ),
          //   child: Row(
          //     children: [
          //       FilterChipWidget(
          //         label: AppStaticStrings.all.tr,
          //         isActive: true,
          //       ),
          //       FilterChipWidget(
          //         label: AppStaticStrings.unseen.tr,
          //         isActive: false,
          //       ),
          //       FilterChipWidget(
          //         label: AppStaticStrings.seen.tr,
          //         isActive: false,
          //       ),
          //       FilterChipWidget(
          //         label: AppStaticStrings.friends.tr,
          //         isActive: false,
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}
