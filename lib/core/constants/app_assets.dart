/// Central registry for all asset paths.
/// Import this instead of writing raw strings anywhere in the codebase.
class AppAssets {
  AppAssets._();

  // ── Images ────────────────────────────────────────────────
  static const String colorLogo = 'assets/images/color_logo.svg';
  static const String colorNameLogo = 'assets/images/color_name_logo.svg';
  static const String darkNameLogo = 'assets/images/dark_name_logo.svg';
  static const String lightNameLogo = 'assets/images/light_name_logo.svg';
  static const String whiteLogo = 'assets/images/white_logo.svg';
  static const String whiteNameLogo = 'assets/images/white_name_logo.svg';
  static const String onboardingHero = 'assets/images/onboarding_hero.svg';

  // ── Icons ─────────────────────────────────────────────────
  static const String blinkSprite = 'assets/icons/blink-sprite.svg';
  static const String iconsJson = 'assets/icons/icons.json';

  // ── Animated ──────────────────────────────────────────────
  static const String splashVideo = 'assets/animations/blink-logo-transparent.webm';
  static const String loadingVideo = 'assets/animations/loading.webm';
}
