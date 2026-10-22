part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// ส่งชื่อ อีเมล และรหัสผ่านให้ Bloc สมัครสมาชิก
final class AuthSignUp extends AuthEvent {
  // ข้อมูลจากฟอร์มที่ Bloc จะส่งต่อไปสมัครสมาชิก
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}
