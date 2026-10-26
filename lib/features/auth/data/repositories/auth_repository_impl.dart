import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Concrete implementation of [AuthRepository].
/// Delegates to the data sources — easy to swap for a real API later.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  const AuthRepositoryImpl(this._remote);

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      _remote.login(email: email, password: password);

  @override
  Future<void> logout() async {
    // TODO: call remote logout endpoint when available
  }
}
