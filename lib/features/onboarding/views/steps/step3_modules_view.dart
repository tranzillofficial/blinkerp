import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../controllers/onboarding_controller.dart';

class Step3ModulesView extends StatelessWidget {
  const Step3ModulesView({super.key, required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6366F1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'onboarding_step3_title'.tr,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF0F172A),
        ),
        const SizedBox(height: 6),
        CustomText(
          text: 'onboarding_step3_subtitle'.tr,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.4,
        ),
        const SizedBox(height: 24),

        // Grid of Modules
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth >= 540 ? 2 : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.availableModules.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 12,
                childAspectRatio: crossAxisCount == 2 ? 3.0 : 4.0,
              ),
              itemBuilder: (context, index) {
                final module = controller.availableModules[index];

                return Obx(() {
                  final isSelected = controller.selectedModules.contains(
                    module.id,
                  );

                  return InkWell(
                    onTap: () => controller.toggleModule(module.id),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? primaryPurple
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.8 : 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isSelected ? 0.04 : 0.015,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Icon
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryPurple.withValues(alpha: 0.1)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              module.iconPath,
                              colorFilter: ColorFilter.mode(
                                isSelected
                                    ? primaryPurple
                                    : const Color(0xFF64748B),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Titles
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: module.titleKey.tr,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                CustomText(
                                  text: module.descKey.tr,
                                  fontSize: 10.5,
                                  color: const Color(0xFF64748B),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Checkbox Indicator
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: isSelected
                                  ? primaryPurple
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? primaryPurple
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );
          },
        ),
      ],
    );
  }
}
