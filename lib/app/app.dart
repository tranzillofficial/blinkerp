import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core/theme/app_theme.dart';
import '../core/localization/app_translations.dart';
import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';

/// Root widget. Thin — configuration only, no business logic.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Read stored language before InitialBinding runs (GetStorage is already
    // initialised in main.dart so this read is safe).
    final box = GetStorage();
    final lang = box.read<String>('app_language') ?? 'ar';

    return GetMaterialApp(
      title: 'Blink ERP',
      debugShowCheckedModeBanner: false,

      // ── Localization ──────────────────────────────────────
      translations: AppTranslations(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(lang),
      fallbackLocale: const Locale('en'),

      // ── Theme ─────────────────────────────────────────────
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,

      // ── DI ────────────────────────────────────────────────
      initialBinding: InitialBinding(),

      // ── Routing ───────────────────────────────────────────
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
