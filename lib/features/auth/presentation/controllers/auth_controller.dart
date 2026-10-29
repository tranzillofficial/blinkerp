import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/app_routes.dart';

/// Manages all auth-screen state: form validation, loading, error display,
/// and navigation between login, register, forgot-password, and OTP verification.
class AuthController extends GetxController {
  // ── Login Form ────────────────────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ── Register Form ─────────────────────────────────────────────────────────
  final registerFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final agreeToTerms = false.obs;
  final obscureRegisterPassword = true.obs;
  final obscureRegisterConfirm = true.obs;

  // ── Forgot Password Form ──────────────────────────────────────────────────
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final forgotEmailController = TextEditingController();

  // ── OTP Verification ──────────────────────────────────────────────────────
  final otpController = TextEditingController();
  final otpEmail = ''.obs;
  final canResendOtp = true.obs;
  final resendCountdown = 0.obs;

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;
  final errorMessage = ''.obs;

  // ── Computed ──────────────────────────────────────────────────────────────
  bool get hasError => errorMessage.value.isNotEmpty;

  // ── Password visibility ───────────────────────────────────────────────────
  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleRegisterPassword() => obscureRegisterPassword.toggle();
  void toggleRegisterConfirm() => obscureRegisterConfirm.toggle();

  // ── Remember-me & Terms ───────────────────────────────────────────────────
  void toggleRememberMe() => rememberMe.toggle();
  void setRememberMe(bool? value) => rememberMe.value = value ?? false;
  void toggleTerms() => agreeToTerms.toggle();
  void setAgreeToTerms(bool? value) => agreeToTerms.value = value ?? false;

  // ── Validation ────────────────────────────────────────────────────────────
  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'auth_email_required'.tr;

    final emailRegex = RegExp(
      r'^[\w.!#$%&*+/=?^_`{|}~-]+@[\w-]+(\.[\w-]+)+$',
    );
    if (!emailRegex.hasMatch(email)) return 'auth_email_invalid'.tr;
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'auth_password_required'.tr;
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Must contain at least one letter (Latin or Arabic)
    if (!RegExp(r'[a-zA-Z\u0600-\u06FF]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 3) return 'Enter your full name';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (value.trim().length < 8) return 'Enter a valid phone number';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm your password';
    if (value != registerPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  /// Login action. Navigates to [AppRoutes.onboarding] temporarily until backend is ready.
  Future<void> login() async {
    if (isLoading.value) return;
    errorMessage.value = '';

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      Get.offAllNamed(AppRoutes.onboarding);
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Register action. Validates form and terms, then routes to OTP or Onboarding.
  Future<void> register() async {
    if (isLoading.value) return;
    errorMessage.value = '';

    final isValid = registerFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Terms of Service',
        'Please accept the terms and conditions to continue.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      otpEmail.value = registerEmailController.text.trim();
      Get.toNamed(AppRoutes.otpVerification, arguments: otpEmail.value);
    } catch (_) {
      errorMessage.value = 'Failed to create account. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Sends password recovery OTP code to the given email.
  Future<void> sendPasswordReset() async {
    if (isLoading.value) return;
    errorMessage.value = '';

    final isValid = forgotPasswordFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      otpEmail.value = forgotEmailController.text.trim();
      Get.toNamed(AppRoutes.otpVerification, arguments: otpEmail.value);
    } catch (_) {
      errorMessage.value = 'Failed to send reset code. Please check your email.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Verifies OTP code.
  Future<void> verifyOtp(String code) async {
    if (isLoading.value) return;
    errorMessage.value = '';

    if (code.length < 4) {
      errorMessage.value = 'Please enter a valid verification code.';
      return;
    }

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      Get.snackbar(
        'Success',
        'Verification successful!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      Get.offAllNamed(AppRoutes.onboarding);
    } catch (_) {
      errorMessage.value = 'Invalid or expired code. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Resends verification code.
  Future<void> resendOtp() async {
    if (!canResendOtp.value) return;

    canResendOtp.value = false;
    resendCountdown.value = 60;

    Get.snackbar(
      'Code Sent',
      'A new verification code was sent to your email.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );

    // Countdown timer
    while (resendCountdown.value > 0) {
      await Future<void>.delayed(const Duration(seconds: 1));
      resendCountdown.value--;
    }
    canResendOtp.value = true;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void showNotImplemented(String feature) {
    Get.snackbar(
      feature,
      'This feature is not connected yet.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    forgotEmailController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
