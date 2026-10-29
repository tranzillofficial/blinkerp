import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/storage/local_storage.dart';

/// Business activity definition for Step 1
class BusinessActivityModel {
  final String id;
  final String titleKey;
  final String descKey;
  final String iconPath;
  final Color iconBgColor;
  final Color iconTintColor;
  final bool isCustomDashed;

  const BusinessActivityModel({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.iconPath,
    required this.iconBgColor,
    required this.iconTintColor,
    this.isCustomDashed = false,
  });
}

/// Module definition for Step 3
class BusinessModuleModel {
  final String id;
  final String titleKey;
  final String descKey;
  final String iconPath;

  const BusinessModuleModel({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.iconPath,
  });
}

class OnboardingController extends GetxController {
  final RxInt currentStep = 0.obs;
  final int totalSteps = 4;

  // ── Step 1: Business Activity ─────────────────────────────────
  final RxString selectedActivityId = 'restaurant'.obs;

  final List<BusinessActivityModel> activities = const [
    BusinessActivityModel(
      id: 'restaurant',
      titleKey: 'act_restaurant',
      descKey: 'act_restaurant_desc',
      iconPath: 'assets/icons/activity/restaurant.svg',
      iconBgColor: Color(0xFFF3E8FF),
      iconTintColor: Color(0xFF8B5CF6),
    ),
    BusinessActivityModel(
      id: 'pharmacy',
      titleKey: 'act_pharmacy',
      descKey: 'act_pharmacy_desc',
      iconPath: 'assets/icons/clinic/pharmacy.svg',
      iconBgColor: Color(0xFFE0F2FE),
      iconTintColor: Color(0xFF2563EB),
    ),
    BusinessActivityModel(
      id: 'clinic',
      titleKey: 'act_clinic',
      descKey: 'act_clinic_desc',
      iconPath: 'assets/icons/clinic/stethoscope.svg',
      iconBgColor: Color(0xFFCCFBF1),
      iconTintColor: Color(0xFF0D9488),
    ),
    BusinessActivityModel(
      id: 'supermarket',
      titleKey: 'act_supermarket',
      descKey: 'act_supermarket_desc',
      iconPath: 'assets/icons/retail/shopping-bag.svg',
      iconBgColor: Color(0xFFFEF3C7),
      iconTintColor: Color(0xFFD97706),
    ),
    BusinessActivityModel(
      id: 'wholesale',
      titleKey: 'act_wholesale',
      descKey: 'act_wholesale_desc',
      iconPath: 'assets/icons/module/warehouse.svg',
      iconBgColor: Color(0xFFEDE9FE),
      iconTintColor: Color(0xFF7C3AED),
    ),
    BusinessActivityModel(
      id: 'retail',
      titleKey: 'act_retail',
      descKey: 'act_retail_desc',
      iconPath: 'assets/icons/activity/retail.svg',
      iconBgColor: Color(0xFFFFE4E6),
      iconTintColor: Color(0xFFE11D48),
    ),
    BusinessActivityModel(
      id: 'services',
      titleKey: 'act_services',
      descKey: 'act_services_desc',
      iconPath: 'assets/icons/activity/services.svg',
      iconBgColor: Color(0xFFE0F2FE),
      iconTintColor: Color(0xFF0284C7),
    ),
    BusinessActivityModel(
      id: 'other',
      titleKey: 'act_other',
      descKey: 'act_other_desc',
      iconPath: 'assets/icons/common/add.svg',
      iconBgColor: Color(0xFFEDE9FE),
      iconTintColor: Color(0xFF6366F1),
      isCustomDashed: true,
    ),
  ];

  // ── Step 2: Company Details ──────────────────────────────────
  final TextEditingController companyNameController = TextEditingController();
  final RxString selectedCountry = 'SA'.obs;
  final RxString selectedCurrency = 'SAR'.obs;
  final RxInt branchesCount = 1.obs;

  // ── Step 3: Modules ──────────────────────────────────────────
  final RxSet<String> selectedModules = <String>{
    'pos',
    'inventory',
    'invoices',
    'accounting',
  }.obs;

  final List<BusinessModuleModel> availableModules = const [
    BusinessModuleModel(
      id: 'pos',
      titleKey: 'mod_pos',
      descKey: 'mod_pos_desc',
      iconPath: 'assets/icons/module/pos.svg',
    ),
    BusinessModuleModel(
      id: 'inventory',
      titleKey: 'mod_inventory',
      descKey: 'mod_inventory_desc',
      iconPath: 'assets/icons/module/inventory.svg',
    ),
    BusinessModuleModel(
      id: 'invoices',
      titleKey: 'mod_invoices',
      descKey: 'mod_invoices_desc',
      iconPath: 'assets/icons/module/invoices.svg',
    ),
    BusinessModuleModel(
      id: 'accounting',
      titleKey: 'mod_accounting',
      descKey: 'mod_accounting_desc',
      iconPath: 'assets/icons/module/accounting.svg',
    ),
    BusinessModuleModel(
      id: 'hr',
      titleKey: 'mod_hr',
      descKey: 'mod_hr_desc',
      iconPath: 'assets/icons/module/hr.svg',
    ),
    BusinessModuleModel(
      id: 'kitchen',
      titleKey: 'mod_kitchen',
      descKey: 'mod_kitchen_desc',
      iconPath: 'assets/icons/module/kitchen.svg',
    ),
    BusinessModuleModel(
      id: 'customers',
      titleKey: 'mod_customers',
      descKey: 'mod_customers_desc',
      iconPath: 'assets/icons/module/customers.svg',
    ),
    BusinessModuleModel(
      id: 'reports',
      titleKey: 'mod_reports',
      descKey: 'mod_reports_desc',
      iconPath: 'assets/icons/module/reports.svg',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _applyPresetForActivity('restaurant');
  }

  @override
  void onClose() {
    companyNameController.dispose();
    super.onClose();
  }

  void selectActivity(String activityId) {
    selectedActivityId.value = activityId;
    _applyPresetForActivity(activityId);
  }

  void _applyPresetForActivity(String id) {
    switch (id) {
      case 'restaurant':
        selectedModules.assignAll({'pos', 'inventory', 'kitchen', 'invoices'});
        break;
      case 'pharmacy':
        selectedModules.assignAll({'pos', 'inventory', 'invoices', 'accounting'});
        break;
      case 'clinic':
        selectedModules.assignAll({'invoices', 'customers', 'reports', 'accounting'});
        break;
      case 'supermarket':
        selectedModules.assignAll({'pos', 'inventory', 'invoices', 'reports'});
        break;
      case 'wholesale':
        selectedModules.assignAll({'inventory', 'invoices', 'accounting', 'customers'});
        break;
      case 'retail':
        selectedModules.assignAll({'pos', 'inventory', 'invoices', 'customers'});
        break;
      case 'services':
        selectedModules.assignAll({'invoices', 'accounting', 'customers', 'reports'});
        break;
      case 'other':
      default:
        selectedModules.assignAll({'pos', 'inventory', 'invoices', 'accounting'});
        break;
    }
  }

  void toggleModule(String moduleId) {
    if (selectedModules.contains(moduleId)) {
      if (selectedModules.length > 1) {
        selectedModules.remove(moduleId);
      }
    } else {
      selectedModules.add(moduleId);
    }
  }

  bool get canGoBack => currentStep.value > 0;

  void back() {
    if (canGoBack) {
      currentStep.value--;
    } else {
      // If at step 0, clicking back takes to login or skip
      skip();
    }
  }

  void next() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      finish();
    }
  }

  void skip() => finish();

  Future<void> finish() async {
    await Get.find<LocalStorage>().setFirstLaunchDone();
    Get.offAllNamed(AppRoutes.login);
  }
}
