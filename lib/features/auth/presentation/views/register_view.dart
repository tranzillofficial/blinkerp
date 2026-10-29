import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/support.dart';
import '../../../../core/widgets/window_title_bar.dart';
import '../controllers/auth_controller.dart';

/// Compact, two-column register screen matching BlinkERP standards.
class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  static const Color _primary = Color(0xFF6C63FF);

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF9898A6)),
      prefixIcon: Icon(icon, size: 17, color: const Color(0xFF7E7E8F)),
      suffixIcon: suffix,
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF7F7FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleBarController = Get.put(CustomTitleBarController());

    return Scaffold(
      body: Obx(() {
        final isWindowed = titleBarController.isWindowed;

        return Stack(
          children: [
            // ── Main Content ──────────────────────────────────────────
            Positioned.fill(
              top: isWindowed ? 34 : 0,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Form(
                      key: controller.registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ── Brand Logo Name ───────────────────────────────
                          Center(
                            child: SvgPicture.asset(
                              AppAssets.colorNameLogo,
                              width: 135,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // ── Heading ────────────────────────────────────────
                          const Text(
                            'Create your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              color: Color(0xFF20202A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Start managing your entire business with BlinkERP.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF777784),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Row 1: Full Name & Phone Number ───────────────
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Full Name
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Full Name',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TextFormField(
                                      controller:
                                          controller.registerNameController,
                                      style: const TextStyle(fontSize: 12.5),
                                      validator: controller.validateName,
                                      textInputAction: TextInputAction.next,
                                      decoration: _fieldDecoration(
                                        hint: 'John Doe',
                                        icon: Icons.person_outline_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Phone
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Phone number',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TextFormField(
                                      controller:
                                          controller.registerPhoneController,
                                      style: const TextStyle(fontSize: 12.5),
                                      keyboardType: TextInputType.phone,
                                      validator: controller.validatePhone,
                                      textInputAction: TextInputAction.next,
                                      decoration: _fieldDecoration(
                                        hint: '+966 50 000 0000',
                                        icon: Icons.phone_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // ── Row 2: Email Address (Full Width) ──────────────
                          const Text(
                            'Email address',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: controller.registerEmailController,
                            style: const TextStyle(fontSize: 12.5),
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.validateEmail,
                            textInputAction: TextInputAction.next,
                            decoration: _fieldDecoration(
                              hint: 'name@company.com',
                              icon: Icons.mail_outline_rounded,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ── Row 3: Password & Confirm Password ─────────────
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Password
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Obx(
                                      () => TextFormField(
                                        controller: controller
                                            .registerPasswordController,
                                        style: const TextStyle(fontSize: 12.5),
                                        obscureText: controller
                                            .obscureRegisterPassword.value,
                                        validator: controller.validatePassword,
                                        textInputAction: TextInputAction.next,
                                        decoration: _fieldDecoration(
                                          hint: 'Min 8 chars & 1 letter',
                                          icon: Icons.lock_outline_rounded,
                                          suffix: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: Icon(
                                              controller
                                                      .obscureRegisterPassword
                                                      .value
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              size: 16,
                                              color: const Color(0xFF7E7E8F),
                                            ),
                                            onPressed: controller
                                                .toggleRegisterPassword,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Confirm Password
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Confirm password',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Obx(
                                      () => TextFormField(
                                        controller: controller
                                            .registerConfirmPasswordController,
                                        style: const TextStyle(fontSize: 12.5),
                                        obscureText: controller
                                            .obscureRegisterConfirm.value,
                                        validator:
                                            controller.validateConfirmPassword,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            controller.register(),
                                        decoration: _fieldDecoration(
                                          hint: 'Repeat password',
                                          icon: Icons.lock_outline_rounded,
                                          suffix: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: Icon(
                                              controller
                                                      .obscureRegisterConfirm
                                                      .value
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              size: 16,
                                              color: const Color(0xFF7E7E8F),
                                            ),
                                            onPressed: controller
                                                .toggleRegisterConfirm,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // ── Terms & Conditions Checkbox ────────────────────
                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: controller.agreeToTerms.value,
                                    onChanged: controller.setAgreeToTerms,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor: _primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    'I agree to the Terms of Service and Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF555562),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ── Error banner ───────────────────────────────────
                          Obx(() {
                            if (!controller.hasError) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F0),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFFFFCCC7),
                                  ),
                                ),
                                child: Text(
                                  controller.errorMessage.value,
                                  style: const TextStyle(
                                    color: Color(0xFFB42318),
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 14),

                          // ── Register Button ────────────────────────────────
                          Obx(
                            () => SizedBox(
                              height: 42,
                              child: FilledButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.register,
                                style: FilledButton.styleFrom(
                                  backgroundColor: _primary,
                                  disabledBackgroundColor:
                                      _primary.withValues(alpha: 0.6),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  elevation: 0,
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Create account',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ── Link to Sign in ────────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF777784),
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.back(),
                                borderRadius: BorderRadius.circular(4),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                      color: _primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Floating / Pinned Title Bar ───────────────────────────
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomTitleBar(),
            ),

            // ── Dynamic Support Button (Switches side with RTL/LTR + bottom padding) ──
            const PositionedDirectional(
              bottom: 34,
              end: 28,
              child: SupportButton(),
            ),
          ],
        );
      }),
    );
  }
}
