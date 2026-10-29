import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/support.dart';
import '../../../../core/widgets/window_title_bar.dart';
import '../controllers/auth_controller.dart';

/// OTP code verification screen with 6-digit input boxes and countdown timer.
class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  static const Color _primary = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    final titleBarController = Get.put(CustomTitleBarController());
    final email = (Get.arguments as String?) ?? controller.otpEmail.value;

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Icon ─────────────────────────────────────────────
                        Center(
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: _primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mark_email_read_outlined,
                              color: _primary,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Heading ───────────────────────────────────────────
                        const Text(
                          'Check your email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: Color(0xFF20202A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          email.isNotEmpty
                              ? 'We sent a verification code to\n$email'
                              : 'Enter the verification code sent to your email.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: Color(0xFF777784),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── 6-Digit Code Input ───────────────────────────────
                        _OtpInputSection(controller: controller),

                        // ── Error banner ──────────────────────────────────────
                        Obx(() {
                          if (!controller.hasError) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
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
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFFB42318),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // ── Verify Button ────────────────────────────────────
                        Obx(
                          () => SizedBox(
                            height: 44,
                            child: FilledButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.verifyOtp(
                                      controller.otpController.text),
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
                                      'Verify code',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Resend Code ──────────────────────────────────────
                        Obx(() {
                          final canResend = controller.canResendOtp.value;
                          final seconds = controller.resendCountdown.value;

                          if (!canResend) {
                            return Center(
                              child: Text(
                                'Resend code in ${seconds.toString().padLeft(2, '0')}s',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8E8E9E),
                                ),
                              ),
                            );
                          }

                          return Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Didn't receive the code? ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF777784),
                                  ),
                                ),
                                InkWell(
                                  onTap: controller.resendOtp,
                                  borderRadius: BorderRadius.circular(4),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      'Resend',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: _primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 16),

                        // ── Back to Sign in ──────────────────────────────────
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

/// 6-digit OTP code input boxes.
class _OtpInputSection extends StatefulWidget {
  const _OtpInputSection({required this.controller});

  final AuthController controller;

  @override
  State<_OtpInputSection> createState() => _OtpInputSectionState();
}

class _OtpInputSectionState extends State<_OtpInputSection> {
  final List<TextEditingController> _boxControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _syncFullCode() {
    final code = _boxControllers.map((c) => c.text).join();
    widget.controller.otpController.text = code;
    if (code.length == 6) {
      widget.controller.verifyOtp(code);
    }
  }

  @override
  void dispose() {
    for (final c in _boxControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 44,
          height: 48,
          child: TextFormField(
            controller: _boxControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              filled: true,
              fillColor: const Color(0xFFF7F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF6C63FF),
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
              _syncFullCode();
            },
          ),
        );
      }),
    );
  }
}
