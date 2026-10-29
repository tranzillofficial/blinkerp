import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/window_title_bar.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_language_button.dart';
import '../widgets/onboarding_progress_bar.dart';
import 'steps/step1_activity_view.dart';
import 'steps/step2_company_view.dart';
import 'steps/step3_modules_view.dart';
import 'steps/step4_ready_view.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final titleBarController = Get.put(CustomTitleBarController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final isWindowed = titleBarController.isWindowed;

        return Stack(
          children: [
            // ── Background Ambient Decorative Blobs ───────────────────
            const _AmbientBackgroundDecoration(),

            // ── Main Content Area ─────────────────────────────────────
            Positioned.fill(
              top: isWindowed ? 34 : 0,
              child: Row(
                children: [
                  // ── Left Column: Form & Wizard Content (flex 62) ────
                  Expanded(
                    flex: 62,
                    child: SafeArea(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 32,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 820),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Top Bar: Logo & Language Switch ───
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.colorNameLogo,
                                      height: 32,
                                    ),
                                    const OnboardingLanguageButton(),
                                  ],
                                ),
                                const SizedBox(height: 32),

                                // ── Step Progress Indicator ───────────
                                Obx(
                                  () => OnboardingProgressBar(
                                    currentStep: controller.currentStep.value,
                                    totalSteps: controller.totalSteps,
                                  ),
                                ),
                                const SizedBox(height: 28),

                                // ── Dynamic Step Content ──────────────
                                Obx(() {
                                  switch (controller.currentStep.value) {
                                    case 0:
                                      return Step1ActivityView(
                                          controller: controller);
                                    case 1:
                                      return Step2CompanyView(
                                          controller: controller);
                                    case 2:
                                      return Step3ModulesView(
                                          controller: controller);
                                    case 3:
                                      return Step4ReadyView(
                                          controller: controller);
                                    default:
                                      return Step1ActivityView(
                                          controller: controller);
                                  }
                                }),
                                const SizedBox(height: 36),

                                // ── Bottom Navigation Controls ────────
                                Obx(() {
                                  final isLastStep =
                                      controller.currentStep.value ==
                                          controller.totalSteps - 1;

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Back Button
                                      TextButton.icon(
                                        onPressed: controller.back,
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              const Color(0xFF64748B),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          size: 16,
                                        ),
                                        label: CustomText(
                                          text: 'onboarding_back'.tr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),

                                      // Continue / Launch Button
                                      ElevatedButton(
                                        onPressed: controller.next,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF6366F1),
                                          foregroundColor: Colors.white,
                                          elevation: 2,
                                          shadowColor: const Color(0xFF6366F1)
                                              .withValues(alpha: 0.4),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                              text: isLastStep
                                                  ? 'onboarding_launch_app'.tr
                                                  : 'onboarding_continue'.tr,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Right Column: 3D Connected Illustration (flex 38) ───
                  Expanded(
                    flex: 38,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 48,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Image.asset(
                            AppAssets.onboardingHero,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Floating / Pinned Title Bar ───────────────────────────
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomTitleBar(),
            ),
          ],
        );
      }),
    );
  }
}

/// Subtle soft lavender/blue radial gradients in the corners matching the screenshot.
class _AmbientBackgroundDecoration extends StatelessWidget {
  const _AmbientBackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Top right ambient glow
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF818CF8).withValues(alpha: 0.09),
                    const Color(0xFFC7D2FE).withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Bottom right ambient glow
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              width: 520,
              height: 520,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFA5B4FC).withValues(alpha: 0.08),
                    const Color(0xFFE0E7FF).withValues(alpha: 0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
