import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/language_switch.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
              child: SizedBox(
                height: constraints.maxHeight < 650 ? 650 : constraints.maxHeight,
                child: Column(
          children: [
            // ── Skip button ───────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Padding(padding: EdgeInsetsDirectional.only(start: 16), child: LanguageSwitch()), Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    'onboarding_skip'.tr,
                    style:
                        const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              )],
            ),

            // ── Hero image ────────────────────────────────────
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SvgPicture.asset(
                  AppAssets.onboardingHero,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // ── Logo ──────────────────────────────────────────
            SvgPicture.asset(AppAssets.colorNameLogo, width: 130),
            const SizedBox(height: 24),

            // ── Animated page text ────────────────────────────
            Expanded(
              flex: 3,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _PageContent(
                    key: ValueKey(controller.currentPage.value),
                    titleKey:
                        controller.pages[controller.currentPage.value].titleKey,
                    bodyKey:
                        controller.pages[controller.currentPage.value].bodyKey,
                  ),
                ),
              ),
            ),

            // ── Dot indicators ────────────────────────────────
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                  (i) => _Dot(active: i == controller.currentPage.value),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── CTA button ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: controller.next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      controller.isLastPage
                          ? 'onboarding_get_started'.tr
                          : 'onboarding_next'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _PageContent extends StatelessWidget {
  final String titleKey;
  final String bodyKey;

  const _PageContent({super.key, required this.titleKey, required this.bodyKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleKey.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            bodyKey.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;
  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.accent : AppColors.dotInactive,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
