import 'package:get_storage/get_storage.dart';

/// Thin, type-safe wrapper around [GetStorage].
/// Accessed via `Get.find<LocalStorage>()`.
class LocalStorage {
  final _box = GetStorage();

  /// Initialise storage (can be called if needed before runApp)
  Future<LocalStorage> init() async {
    await GetStorage.init();
    return this;
  }

  // ── Keys ──────────────────────────────────────────────────
  static const _kFirstLaunch = 'first_launch';
  static const _kLoggedIn = 'is_logged_in';
  static const _kToken = 'auth_token';
  static const _kLanguage = 'app_language';
  static const _kDarkMode = 'app_dark_mode';

  // ── First-launch ──────────────────────────────────────────
  bool get isFirstLaunch => _box.read<bool>(_kFirstLaunch) ?? true;
  Future<void> setFirstLaunchDone() => _box.write(_kFirstLaunch, false);

  // ── Auth ──────────────────────────────────────────────────
  bool get isLoggedIn => _box.read<bool>(_kLoggedIn) ?? false;
  Future<void> setLoggedIn({required bool value}) =>
      _box.write(_kLoggedIn, value);

  String? get authToken => _box.read<String>(_kToken);
  Future<void> setAuthToken(String token) => _box.write(_kToken, token);

  Future<void> clearAuth() async {
    await _box.remove(_kToken);
    await _box.write(_kLoggedIn, false);
  }

  // ── Preferences ───────────────────────────────────────────
  String get language => _box.read<String>(_kLanguage) ?? 'ar';
  Future<void> setLanguage(String lang) => _box.write(_kLanguage, lang);

  bool get isDarkMode => _box.read<bool>(_kDarkMode) ?? true;
  Future<void> setDarkMode({required bool value}) =>
      _box.write(_kDarkMode, value);
}

/// Alias for developers expecting [StorageService]
typedef StorageService = LocalStorage;
