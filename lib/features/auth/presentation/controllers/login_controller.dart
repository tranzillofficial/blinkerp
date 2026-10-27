import 'package:get/get.dart';

/// Presentation state only. No credentials are sent or persisted.
class LoginController extends GetxController {
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final errorMessage = ''.obs;
  void togglePasswordVisibility() => obscurePassword.toggle();
  Future<void> login({required String email, required String password}) async {
    if (isLoading.value) return;
    errorMessage.value = '';
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1800));
    if (isClosed) return;
    isLoading.value = false;
    errorMessage.value = 'auth_preview_only'.tr;
  }
}
