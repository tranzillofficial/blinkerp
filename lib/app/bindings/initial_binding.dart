import 'package:get/get.dart';
import '../../core/storage/local_storage.dart';

/// Registers all permanent, app-wide services before the first page loads.
/// Feature-specific dependencies are handled by their own [Bindings].
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocalStorage>(LocalStorage(), permanent: true);
  }
}
