import '../../domain/entities/auth_user.dart';

/// Contract for the remote auth data source.
abstract class AuthRemoteDataSource {
  Future<AuthUser> login({
    required String email,
    required String password,
  });
}
