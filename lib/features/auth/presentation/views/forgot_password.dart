import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/support.dart';
import '../../../../core/widgets/window_title_bar.dart';
import '../controllers/auth_controller.dart';

/// Password recovery screen.
class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  static const Color _primary = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    final titleBarController = Get.put(CustomTitleBarController());

    // Pre-fill email if passed in arguments
    if (Get.arguments is String &&
        controller.forgotEmailController.text.isEmpty) {
      controller.forgotEmailController.text = Get.arguments as String;
    }

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
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: controller.forgotPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ── Lock Icon ──────────────────────────────────────
                          Center(
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: _primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock_reset_rounded,
                                color: _primary,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Heading ────────────────────────────────────────
                          const Text(
                            'Forgot password?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: Color(0xFF20202A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'No worries, enter your registered email address and we will send you a verification code.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.5,
                              color: Color(0xFF777784),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Email Field ────────────────────────────────────
                          const Text(
                            'Email address',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: controller.forgotEmailController,
                            style: const TextStyle(fontSize: 13),
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.validateEmail,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) =>
                                controller.sendPasswordReset(),
                            decoration: InputDecoration(
                              hintText: 'name@company.com',
                              hintStyle: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF9898A6),
                              ),
                              prefixIcon: const Icon(
                                Icons.mail_outline_rounded,
                                size: 18,
                                color: Color(0xFF7E7E8F),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: const Color(0xFFF7F7FA),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE7E7EF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: _primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          // ── Error banner ───────────────────────────────────
                          Obx(() {
                            if (!controller.hasError) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F0),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFFFCCC7),
                                  ),
                                ),
                                child: Text(
                                  controller.errorMessage.value,
                                  style: const TextStyle(
                                    color: Color(0xFFB42318),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 20),

                          // ── Submit Button ──────────────────────────────────
                          Obx(
                            () => SizedBox(
                              height: 44,
                              child: FilledButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.sendPasswordReset,
                                style: FilledButton.styleFrom(
                                  backgroundColor: _primary,
                                  disabledBackgroundColor:
                                      _primary.withValues(alpha: 0.6),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Send verification code',
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── Back to Sign in ────────────────────────────────
                          Center(
                            child: InkWell(
                              onTap: () => Get.back(),
                              borderRadius: BorderRadius.circular(4),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_rounded,
                                      size: 16,
                                      color: Color(0xFF777784),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Back to Sign in',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF555562),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
