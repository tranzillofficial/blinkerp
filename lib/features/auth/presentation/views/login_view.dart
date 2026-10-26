import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_text_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // ── Logo ────────────────────────────────────────
                SvgPicture.asset(AppAssets.colorNameLogo, width: 160),

                const SizedBox(height: 40),

                // ── Card ────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.surfaceBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Heading ──────────────────────────────
                      Text(
                        'auth_welcome_back'.tr,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'auth_sign_in_to_continue'.tr,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 14),
                      ),

                      const SizedBox(height: 32),

                      // ── Email field ──────────────────────────
                      AuthTextField(
                        label: 'auth_email'.tr,
                        hint: 'auth_email_hint'.tr,
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'auth_email_required'.tr;
                          }
                          if (!GetUtils.isEmail(v)) {
                            return 'auth_email_invalid'.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Password field ───────────────────────
                      Obx(
                        () => AuthTextField(
                          label: 'auth_password'.tr,
                          hint: 'auth_password_hint'.tr,
                          controller: passwordCtrl,
                          obscureText: controller.obscurePassword.value,
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                            onPressed:
                                controller.togglePasswordVisibility,
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'auth_password_required'.tr;
                            }
                            if (v.length < 6) {
                              return 'auth_password_min'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Remember me + Forgot password ────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (_) =>
                                        controller.toggleRememberMe(),
                                    activeColor: AppColors.accent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4)),
                                    side: const BorderSide(
                                        color: AppColors.textHint),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'auth_remember_me'.tr,
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: forgot password route
                            },
                            child: Text(
                              'auth_forgot_password'.tr,
                              style: const TextStyle(
                                  color: AppColors.accent, fontSize: 13),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Error banner ─────────────────────────
                      Obx(
                        () => controller.errorMessage.value.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.error
                                        .withValues(alpha: 0.1),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.error
                                            .withValues(alpha: 0.6),
                                        width: 1),
                                  ),
                                  child: Text(
                                    controller.errorMessage.value,
                                    style: TextStyle(
                                        color: AppColors.error
                                            .withValues(alpha: 0.9),
                                        fontSize: 13),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // ── Login button ─────────────────────────
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      controller.login(
                                        email: emailCtrl.text.trim(),
                                        password: passwordCtrl.text.trim(),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                                  AppColors.accent.withValues(alpha: 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'auth_login'.tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ── Footer ──────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'auth_no_account'.tr,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(width: 6),
                    TextButton(
                      onPressed: () {
                        // TODO: contact admin route
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap),
                      child: Text(
                        'auth_contact_admin'.tr,
                        style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Logo watermark ───────────────────────────────
                Opacity(
                  opacity: 0.15,
                  child: SvgPicture.asset(AppAssets.whiteLogo, width: 36),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
