import '../entities/auth_user.dart';

/// Contract that the data layer must fulfil.
/// The domain layer knows NOTHING about the implementation.
abstract class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
