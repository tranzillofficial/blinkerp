import 'package:get/get.dart';
import 'ar.dart';
import 'en.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_EG': ar,
        'ar_SA': ar,
        'ar_AE': ar,
        'ar': ar,
        'en': en,
      };
}
