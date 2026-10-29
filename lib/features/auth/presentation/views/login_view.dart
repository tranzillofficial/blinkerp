import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../controllers/auth_controller.dart';
import 'layouts/desktop/login_desktop_layout.dart';
import 'layouts/mobile/login_mobile_layout.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Guarantees AuthController is always instantiated regardless of navigation method
    final controller = Get.put(AuthController());

    return PopScope(
      canPop: false,
      child: ResponsiveLayout(
        mobile: LoginMobileLayout(controller: controller),
        desktop: LoginDesktopLayout(controller: controller),
      ),
    );
  }
}
