/// Pure domain entity — no Flutter, no GetX, no infrastructure dependency.
class AuthUser {
  final String id;
  final String email;
  final String name;
  final String role;
  final String token;

  const AuthUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.token,
  });
}
