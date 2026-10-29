import '../../core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/app_assets.dart';
import '../storage/local_storage.dart';
import '../theme/app_colors.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    return TextButton.icon(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: () async {
        final language = isArabic ? 'en' : 'ar';
        await Get.find<LocalStorage>().setLanguage(language);
        await Get.updateLocale(Locale(language));
      },
      icon: SvgPicture.asset(
        AppAssets.language,
        height: 18,
        width: 18,
        colorFilter: const ColorFilter.mode(
          AppColors.textPrimary,
          BlendMode.srcIn,
        ),
      ),
      label: CustomText(
        text: isArabic ? 'English' : 'العربية',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
