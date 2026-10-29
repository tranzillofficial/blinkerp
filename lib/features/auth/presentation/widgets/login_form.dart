import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/storage/local_storage.dart';
import '../controllers/auth_controller.dart';

/// Compact, elegant form card shared by both [LoginMobileLayout] and
/// [LoginDesktopLayout]. All state lives in [AuthController].
class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.controller});

  final AuthController controller;

  // ── Theme token — matches AppColors.accent ────────────────────────────────
  static const Color _primary = Color(0xFF6C63FF);

  // ── Helpers ───────────────────────────────────────────────────────────────
  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12.5, color: Color(0xFF9898A6)),
      prefixIcon: Icon(icon, size: 18, color: const Color(0xFF7E7E8F)),
      suffixIcon: suffix,
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF7F7FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header: Brand Logo (with Hero) + Language Switch ──────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'app_brand_logo',
                child: SvgPicture.asset(AppAssets.colorNameLogo, width: 125),
              ),
              const _CompactLanguageSwitch(),
            ],
          ),
          const SizedBox(height: 22),

          // ── Heading ───────────────────────────────────────────────────────
          const Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: Color(0xFF20202A),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Sign in to continue to your workspace.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Color(0xFF777784),
            ),
          ),
          const SizedBox(height: 20),

          // ── Email ─────────────────────────────────────────────────────────
          const _FieldLabel('Email address'),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller.emailController,
            style: const TextStyle(fontSize: 13),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.username],
            validator: controller.validateEmail,
            decoration: _fieldDecoration(
              hint: 'name@company.com',
              icon: Icons.mail_outline_rounded,
            ),
          ),

          const SizedBox(height: 14),

          // ── Password label ────────────────────────────────────────────────
          const _FieldLabel('Password'),
          const SizedBox(height: 6),

          // ── Password field ────────────────────────────────────────────────
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              style: const TextStyle(fontSize: 13),
              obscureText: controller.obscurePassword.value,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              validator: controller.validatePassword,
              onFieldSubmitted: (_) => controller.login(),
              decoration: _fieldDecoration(
                hint: 'Enter your password',
                icon: Icons.lock_outline_rounded,
                suffix: IconButton(
                  onPressed: controller.togglePasswordVisibility,
                  tooltip: controller.obscurePassword.value
                      ? 'Show password'
                      : 'Hide password',
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18,
                    color: const Color(0xFF7E7E8F),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Remember me & Forgot Password (under password field) ───────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember Me Checkbox
              Obx(
                () => InkWell(
                  onTap: controller.toggleRememberMe,
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.setRememberMe,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: _primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF555562),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Small "Forgot password?" Link under the password field
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                style: TextButton.styleFrom(
                  foregroundColor: _primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  minimumSize: const Size(0, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),

          // ── Error banner ──────────────────────────────────────────────────
          Obx(() {
            if (!controller.hasError) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFCCC7)),
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

          const SizedBox(height: 14),

          // ── Sign-in button ────────────────────────────────────────────────
          Obx(
            () => SizedBox(
              height: 44,
              child: FilledButton(
                onPressed: controller.isLoading.value ? null : controller.login,
                style: FilledButton.styleFrom(
                  backgroundColor: _primary,
                  disabledBackgroundColor: _primary.withValues(alpha: 0.6),
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
                        'Sign in',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ── Register navigation link ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 12, color: Color(0xFF777784)),
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.register),
                borderRadius: BorderRadius.circular(4),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'Sign up',
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

          const SizedBox(height: 16),

          // ── Social divider ────────────────────────────────────────────────
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'OR CONTINUE WITH',
                  style: TextStyle(
                    fontSize: 9.5,
                    letterSpacing: 0.8,
                    color: Color(0xFF858592),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 14),

          // ── Social buttons ────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _SocialButton(
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                  onPressed: () =>
                      controller.showNotImplemented('Phone sign-in'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SocialButton(
                  label: 'Google',
                  icon: Icons.g_mobiledata_rounded,
                  onPressed: () =>
                      controller.showNotImplemented('Google sign-in'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SocialButton(
                  label: 'Facebook',
                  icon: Icons.facebook_rounded,
                  onPressed: () =>
                      controller.showNotImplemented('Facebook sign-in'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}

/// Compact, subtle language switch with no background and light hover splash.
class _CompactLanguageSwitch extends StatelessWidget {
  const _CompactLanguageSwitch();

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final targetLang = isArabic ? 'English' : 'العربية';

    return TextButton.icon(
      onPressed: () async {
        final newLang = isArabic ? 'en' : 'ar';
        await Get.find<LocalStorage>().setLanguage(newLang);
        await Get.updateLocale(Locale(newLang));
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF555562),
        overlayColor: const Color(0xFF6C63FF).withValues(alpha: 0.05),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      icon: const Icon(
        Icons.language_rounded,
        size: 15,
        color: Color(0xFF7E7E8F),
      ),
      label: Text(
        targetLang,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF555562),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF33333D),
        side: const BorderSide(color: Color(0xFFE5E5ED)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 11.5)),
          ],
        ),
      ),
    );
  }
}
