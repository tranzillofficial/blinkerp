/// Central registry of all named route strings.
/// Only add stub entries here for future features — never hard-code strings.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Auth Routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String otpVerification = '/otpVerification';
  static const String support = '/support';

  // ── Stubs for future ERP modules ──────────────────────
  static const String dashboard = '/dashboard';
  static const String sales = '/sales';
  static const String purchases = '/purchases';
  static const String inventory = '/inventory';
  static const String customers = '/customers';
  static const String suppliers = '/suppliers';
  static const String accounting = '/accounting';
  static const String reports = '/reports';
  static const String employees = '/employees';
  static const String settings = '/settings';
}
