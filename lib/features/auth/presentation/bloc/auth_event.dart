part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// ส่งชื่อ อีเมล และรหัสผ่านให้ Bloc สมัครสมาชิก
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

// ส่งอีเมลและรหัสผ่านให้ Bloc เข้าสู่ระบบ
final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}
