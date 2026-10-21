part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Event สำหรับสมัครสมาชิก
final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}
