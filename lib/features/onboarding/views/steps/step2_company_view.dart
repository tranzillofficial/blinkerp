import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../controllers/onboarding_controller.dart';

class Step2CompanyView extends StatelessWidget {
  const Step2CompanyView({super.key, required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6366F1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'onboarding_step2_title'.tr,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF0F172A),
        ),
        const SizedBox(height: 6),
        CustomText(
          text: 'onboarding_step2_subtitle'.tr,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.4,
        ),
        const SizedBox(height: 28),

        // Company Name Input
        CustomText(
          text: 'onboarding_company_name'.tr,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E293B),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.companyNameController,
          decoration: InputDecoration(
            hintText: 'onboarding_company_name_hint'.tr,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            prefixIcon: const Icon(
              Icons.store_mall_directory_outlined,
              color: Color(0xFF64748B),
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryPurple, width: 1.8),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Country & Currency Row
        Row(
          children: [
            // Country
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'onboarding_country'.tr,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.selectedCountry.value,
                      items: const [
                        DropdownMenuItem(
                          value: 'SA',
                          child: Text('المملكة العربية السعودية (SA)'),
                        ),
                        DropdownMenuItem(
                          value: 'AE',
                          child: Text('الإمارات العربية المتحدة (AE)'),
                        ),
                        DropdownMenuItem(value: 'EG', child: Text('مصر (EG)')),
                        DropdownMenuItem(
                          value: 'KW',
                          child: Text('الكويت (KW)'),
                        ),
                        DropdownMenuItem(value: 'QA', child: Text('قطر (QA)')),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.selectedCountry.value = val;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Currency
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'onboarding_currency'.tr,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.selectedCurrency.value,
                      items: const [
                        DropdownMenuItem(
                          value: 'SAR',
                          child: Text('SAR - ريال سعودي'),
                        ),
                        DropdownMenuItem(
                          value: 'AED',
                          child: Text('AED - درهم إماراتي'),
                        ),
                        DropdownMenuItem(
                          value: 'EGP',
                          child: Text('EGP - جنيه مصري'),
                        ),
                        DropdownMenuItem(
                          value: 'USD',
                          child: Text('USD - دولار أمريكي'),
                        ),
                        DropdownMenuItem(
                          value: 'KWD',
                          child: Text('KWD - دينار كويتي'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null)
                          controller.selectedCurrency.value = val;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Branches Count
        CustomText(
          text: 'onboarding_branches_count'.tr,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E293B),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [1, 2, 5, 10].map((branches) {
              final isSelected = controller.branchesCount.value == branches;
              final label = branches == 1
                  ? 'فرع واحد (1)'
                  : branches == 2
                  ? 'فرعان (2)'
                  : branches == 5
                  ? '3 - 5 فروع'
                  : 'أكثر من 5 فروع';

              return ChoiceChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (_) => controller.branchesCount.value = branches,
                selectedColor: primaryPurple.withValues(alpha: 0.12),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? primaryPurple : const Color(0xFF475569),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isSelected ? primaryPurple : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.8 : 1.0,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
