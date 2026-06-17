import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:un4seen/src/features/home/presentation/widgets/poll_option_widget.dart';
import '../../../../src_export.dart';

class PollCardWidget extends StatelessWidget {
  final CrewChoiceModel model;
  const PollCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CrewChoiceController>();

    // ─── FIX LOGIC ───
    // Check if the icon we are about to use is an SVG or a PNG
    final String iconPath = model.iconStyle == 'drop' ? AppIcons.logo : AppIcons.reward;
    final bool isSvg = iconPath.toLowerCase().endsWith('.svg');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: isSvg 
                  ? SvgPicture.asset(
                      iconPath,
                      height: 20, 
                      colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn)
                    )
                  : Image.asset(
                      iconPath,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
              ),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(model.title, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    CustomText(model.description, color: Colors.white.withValues(alpha: .9), fontSize: 11),
                  ],
                ),
              ),
            ],
          ),
          space16H,
          ...List.generate(model.options.length, (idx) {
            final option = model.options[idx];
            return PollOptionWidget(
              title: option.label,
              percentage: option.percentage,
              isSelected: model.mySelectionIndex == idx,
                onTap:() => controller.castVote(model.id, idx),
                option: option,
            );
          }), 
          space8H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText("${model.totalVotes} ${AppStaticStrings.votesCount.tr}", color: Colors.white, fontSize: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                    child: CustomText(model.timeLabel.tr, color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  if (model.hasVoted) ...[
                    space8W,
                    const Icon(Icons.check_circle, color: Colors.white, size: 18),
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}