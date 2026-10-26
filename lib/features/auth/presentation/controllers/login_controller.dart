import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';

class LoginController extends GetxController {
  // ── Reactive state ────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool rememberMe = false.obs;
  final RxString errorMessage = ''.obs;

  // ── UI actions ────────────────────────────────────────────
  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleRememberMe() => rememberMe.value = !rememberMe.value;

  // ── Business action ───────────────────────────────────────
  Future<void> login({
    required String email,
    required String password,
  }) async {
    errorMessage.value = '';

    if (password.length < AppConstants.minPasswordLength) {
      errorMessage.value = 'auth_password_min'.tr;
      return;
    }

    isLoading.value = true;
    try {
      // TODO: inject and call LoginUseCase when API is wired up
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (_) {
      errorMessage.value = 'auth_invalid_credentials'.tr;
    } finally {
      isLoading.value = false;
    }
  }
}
