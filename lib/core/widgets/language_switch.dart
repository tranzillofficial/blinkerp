import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../storage/local_storage.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    return TextButton.icon(
      onPressed: () async {
        final language = isArabic ? 'en' : 'ar';
        await Get.find<LocalStorage>().setLanguage(language);
        await Get.updateLocale(Locale(language));
      },
      icon: const Icon(Icons.language, size: 17),
      label: Text(isArabic ? 'English' : 'العربية'),
    );
  }
}
