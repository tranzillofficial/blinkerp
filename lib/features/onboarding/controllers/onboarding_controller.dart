import 'package:get/get.dart';
import '../../../core/storage/local_storage.dart';
import '../../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  final List<OnboardingPageModel> pages = [
    const OnboardingPageModel(
        titleKey: 'onboarding_title_1', bodyKey: 'onboarding_body_1'),
    const OnboardingPageModel(
        titleKey: 'onboarding_title_2', bodyKey: 'onboarding_body_2'),
    const OnboardingPageModel(
        titleKey: 'onboarding_title_3', bodyKey: 'onboarding_body_3'),
  ];

  bool get isLastPage => currentPage.value == pages.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void next() => isLastPage ? _finish() : currentPage.value++;

  void skip() => _finish();

  Future<void> _finish() async {
    await Get.find<LocalStorage>().setFirstLaunchDone();
    Get.offAllNamed(AppRoutes.login);
  }
}

/// Pure data model — no Flutter / GetX dependency.
class OnboardingPageModel {
  final String titleKey;
  final String bodyKey;
  const OnboardingPageModel({required this.titleKey, required this.bodyKey});
}
