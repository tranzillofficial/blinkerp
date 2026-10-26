import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Use-case: login.
/// Validates inputs at the domain level and delegates to the repository.
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<AuthUser> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
