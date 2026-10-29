import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/activity_card.dart';

class Step1ActivityView extends StatelessWidget {
  const Step1ActivityView({super.key, required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        CustomText(
          text: 'onboarding_step1_title'.tr,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF0F172A),
        ),
        const SizedBox(height: 6),

        // Subtitle
        CustomText(
          text: 'onboarding_step1_subtitle'.tr,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.4,
        ),
        const SizedBox(height: 24),

        // 4x2 Grid of Activity Cards
        LayoutBuilder(
          builder: (context, constraints) {
            // Determine column count based on available width:
            // >= 560px: 4 columns (exact design in screenshot)
            // < 560px: 2 columns
            final crossAxisCount = constraints.maxWidth >= 540 ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.activities.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final activity = controller.activities[index];
                return Obx(() {
                  final isSelected =
                      controller.selectedActivityId.value == activity.id;
                  return ActivityCard(
                    activity: activity,
                    isSelected: isSelected,
                    onTap: () => controller.selectActivity(activity.id),
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

