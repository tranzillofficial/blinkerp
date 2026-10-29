import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/widgets/custom_text.dart';

class OnboardingLanguageButton extends StatelessWidget {
  const OnboardingLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';

    return PopupMenuButton<String>(
      tooltip: '',
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      offset: const Offset(0, 36),
      onSelected: (lang) async {
        if (lang != (isArabic ? 'ar' : 'en')) {
          await Get.find<LocalStorage>().setLanguage(lang);
          await Get.updateLocale(Locale(lang));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'ar',
          child: Row(
            children: [
              CustomText(
                text: 'العربية',
                fontSize: 13,
                fontWeight: isArabic ? FontWeight.w700 : FontWeight.w500,
                color: isArabic ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
              ),
              if (isArabic) ...[
                const Spacer(),
                const Icon(Icons.check, size: 16, color: Color(0xFF6366F1)),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              CustomText(
                text: 'English',
                fontSize: 13,
                fontWeight: !isArabic ? FontWeight.w700 : FontWeight.w500,
                color: !isArabic ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
              ),
              if (!isArabic) ...[
                const Spacer(),
                const Icon(Icons.check, size: 16, color: Color(0xFF6366F1)),
              ],
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language,
              size: 18,
              color: Color(0xFF334155),
            ),
            const SizedBox(width: 6),
            CustomText(
              text: isArabic ? 'العربية' : 'English',
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
}

