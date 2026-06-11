import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/tab_content_view.dart';

class DynamicTabWidget extends StatelessWidget {
  final List<String> tabs; // Changed from RxList to regular List
  final List<Widget> tabContent; // Changed from RxList to regular List
  final ValueChanged<int>? onTabChanged; // Renamed from 'function' for clarity
  final int? initialIndex;
  const DynamicTabWidget({
    super.key,
    required this.tabs,
    required this.tabContent,
    this.onTabChanged,
    this.initialIndex,
  }) : assert(
         tabs.length == tabContent.length,
         'Tabs and content must have the same length',
       );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex ?? 0,
      length: tabs.length, // Dynamically set the number of tabs
      child: Column(
        children: [
          Container(
            // backgroundColor: AppColors.kWhiteColor,
            // padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.zero,

              dividerColor: Colors.transparent,
              overlayColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              isScrollable: false,
              // Keep tabs aligned properly
              indicator: BoxDecoration(
                color: AppColors.kPrimaryColor, // Active tab background color
                borderRadius: BorderRadius.circular(20), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2), // Slight shadow for active tab
                  ),
                ],
              ),
              labelColor: AppColors.kWhiteTextColor,
              // Active tab text color
              unselectedLabelColor: AppColors.kTextColor,
              // Inactive tab text color
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
                color: AppColors.kWhiteTextColor,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(
                    fontSize: 14,
                    color: AppColors.kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
              onTap: onTabChanged,
              tabs: tabs
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              Colors.transparent, // Default for inactive tabs
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FittedBox(
                          child: Text(
                            entry.value,
                            // style: Theme.of(context).textTheme.bodyMedium
                            //     ?.copyWith(
                            //       fontSize: 12,
                            //       color: AppColors.kTextColor,
                            //     ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          space12H,
          TabContentView(children: tabContent),
        ],
      ),
    );
  }
}
