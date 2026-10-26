import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/localization/app_translations.dart';
import 'core/services/storage_service.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init persistent storage
  await GetStorage.init();

  // Register core services
  Get.put(StorageService(), permanent: true);

  final storage = Get.find<StorageService>();

  runApp(
    GetMaterialApp(
      title: 'Blinker ERP',
      debugShowCheckedModeBanner: false,

      // ── Localization ────────────────────────────────────
      translations: AppTranslations(),
      locale: Locale(storage.language),
      fallbackLocale: const Locale('en'),

      // ── Theme ───────────────────────────────────────────
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          surface: Color(0xFF131929),
        ),
      ),

      // ── Routing ─────────────────────────────────────────
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    ),
  );
}
