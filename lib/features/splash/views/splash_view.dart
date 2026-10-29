import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/widgets/brand_video.dart';
import '../../auth/presentation/bindings/auth_binding.dart';
import '../../auth/presentation/views/login_view.dart';
import '../../onboarding/views/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _navigated = false;
  bool _showFinalHero = false;

  void _onVideoFinished() {
    if (_navigated || !mounted) return;
    _navigated = true;

    // Initialize auth dependencies ahead of route transition
    AuthBinding().dependencies();

    setState(() {
      _showFinalHero = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final storage = Get.find<LocalStorage>();
      final isFirst = storage.isFirstLaunch;

      Navigator.of(context).push(
        PageRouteBuilder(
          settings: RouteSettings(
            name: isFirst ? AppRoutes.onboarding : AppRoutes.login,
          ),
          pageBuilder: (context, animation, secondaryAnimation) {
            return isFirst ? const OnboardingView() : const LoginView();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _showFinalHero
            // The starting Hero element that flies seamlessly to the Login form
            ? Hero(
                tag: 'app_brand_logo',
                child: SvgPicture.asset(
                  AppAssets.colorNameLogo,
                  width: 200,
                ),
              )
            // Plays the transparent webm animation ONCE (no loop)
            : BrandVideo(
                asset: AppAssets.splashVideo,
                loop: false,
                size: 320,
                onFinished: _onVideoFinished,
              ),
      ),
    );
  }
}
