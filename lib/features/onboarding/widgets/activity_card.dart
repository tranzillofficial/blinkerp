import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/onboarding_controller.dart';
import 'dashed_border.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.isSelected,
    required this.onTap,
  });

  final BusinessActivityModel activity;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6366F1);
    const borderColorUnselected = Color(0xFFE2E8F0);

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: widget.isSelected
            ? Border.all(color: primaryPurple, width: 2.0)
            : widget.activity.isCustomDashed
            ? null // Drawn by DashedBorder wrapper
            : Border.all(
                color: _isHovered
                    ? primaryPurple.withValues(alpha: 0.4)
                    : borderColorUnselected,
                width: 1.5,
              ),
        boxShadow: widget.isSelected
            ? [
                BoxShadow(
                  color: primaryPurple.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: _isHovered ? 0.05 : 0.02,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: Icon Container + Radio Selection Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.activity.iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(9),
                child: SvgPicture.asset(
                  widget.activity.iconPath,
                  colorFilter: ColorFilter.mode(
                    widget.activity.iconTintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              // Selection Radio Indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.isSelected
                        ? primaryPurple
                        : const Color(0xFFCBD5E1),
                    width: 1.8,
                  ),
                ),
                child: widget.isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryPurple,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Titles Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: widget.activity.titleKey.tr,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: widget.activity.descKey.tr,
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );

    // If dashed and unselected, wrap with DashedBorder
    if (!widget.isSelected && widget.activity.isCustomDashed) {
      content = DashedBorder(
        color: _isHovered
            ? primaryPurple.withValues(alpha: 0.5)
            : const Color(0xFFCBD5E1),
        borderRadius: 16,
        strokeWidth: 1.5,
        child: content,
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(onTap: widget.onTap, child: content),
    );
  }
}
