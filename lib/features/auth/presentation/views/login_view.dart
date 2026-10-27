import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/brand_loading.dart';
import '../../../../core/widgets/language_switch.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(child: Center(child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420), child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(alignment: AlignmentDirectional.topEnd, child: LanguageSwitch()),
            const SizedBox(height: 16),
            Center(child: SvgPicture.asset(AppAssets.colorNameLogo, width: 150)),
            const SizedBox(height: 28),
            Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
              color: AppColors.surface, borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surfaceBorder),
            ), child: Form(key: formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('auth_welcome_back'.tr, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('auth_sign_in_to_continue'.tr, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              AuthTextField(label: 'auth_email'.tr, hint: 'auth_email_hint'.tr,
                controller: email, keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined,
                validator: (v) => v == null || v.trim().isEmpty ? 'auth_email_required'.tr : !GetUtils.isEmail(v.trim()) ? 'auth_email_invalid'.tr : null),
              const SizedBox(height: 16),
              Obx(() => AuthTextField(label: 'auth_password'.tr, hint: 'auth_password_hint'.tr,
                controller: password, obscureText: controller.obscurePassword.value, prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(onPressed: controller.togglePasswordVisibility,
                  icon: Icon(controller.obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                validator: (v) => v == null || v.isEmpty ? 'auth_password_required'.tr : v.length < 6 ? 'auth_password_min'.tr : null)),
              const SizedBox(height: 20),
              Obx(() => controller.errorMessage.value.isEmpty ? const SizedBox.shrink() : Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(controller.errorMessage.value, style: const TextStyle(color: AppColors.textSecondary)))),
              Obx(() => controller.isLoading.value
                ? const Center(child: BrandLoading())
                : SizedBox(height: 44, child: ElevatedButton(
                    onPressed: () { if (formKey.currentState!.validate()) { controller.login(email: email.text.trim(), password: password.text); } },
                    child: Text('auth_login'.tr)))),
            ]))),
          ],
        )),
      ))),
    );
  }
}
