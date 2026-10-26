import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/storage/local_storage.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
        const Duration(milliseconds: AppConstants.splashDurationMs));

    final storage = Get.find<LocalStorage>();

    if (storage.isFirstLaunch) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (storage.isLoggedIn) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
