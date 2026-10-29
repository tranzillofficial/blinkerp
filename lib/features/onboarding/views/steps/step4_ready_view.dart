import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../controllers/onboarding_controller.dart';

class Step4ReadyView extends StatelessWidget {
  const Step4ReadyView({super.key, required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6366F1);

    final selectedActivity = controller.activities.firstWhere(
      (a) => a.id == controller.selectedActivityId.value,
      orElse: () => controller.activities.first,
    );

    final companyName = controller.companyNameController.text.trim().isEmpty
        ? 'Blink Store'
        : controller.companyNameController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'onboarding_step4_title'.tr,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF0F172A),
        ),
        const SizedBox(height: 6),
        CustomText(
          text: 'onboarding_step4_subtitle'.tr,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.4,
        ),
        const SizedBox(height: 24),

        // Summary Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity Row
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: selectedActivity.iconBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      selectedActivity.iconPath,
                      colorFilter: ColorFilter.mode(
                        selectedActivity.iconTintColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: companyName,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        const SizedBox(height: 2),
                        CustomText(
                          text: selectedActivity.titleKey.tr,
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Color(0xFF16A34A),
                        ),
                        SizedBox(width: 4),
                        CustomText(
                          text: 'جاهز',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF16A34A),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFF1F5F9), height: 1),
              ),

              // Summary Details Grid
              Row(
                children: [
                  // Currency
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'onboarding_summary_currency'.tr,
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: controller.selectedCurrency.value,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ],
                    ),
                  ),
                  // Branches
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'onboarding_branches_count'.tr,
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: '${controller.branchesCount.value} فرع',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Active Modules Badges
              CustomText(
                text: 'onboarding_summary_modules'.tr,
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.selectedModules.map((modId) {
                  final mod = controller.availableModules.firstWhere(
                    (m) => m.id == modId,
                    orElse: () => controller.availableModules.first,
                  );
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: primaryPurple.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryPurple.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          mod.iconPath,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            primaryPurple,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          text: mod.titleKey.tr,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: primaryPurple,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
