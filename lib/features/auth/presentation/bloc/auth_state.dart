part of 'auth_bloc.dart';

// สถานะของระบบยืนยันตัวตน
@immutable
sealed class AuthState {
  const AuthState();
}

// สถานะเริ่มต้น
final class AuthInitial extends AuthState {}

// สถานะกำลังดำเนินการ
final class AuthLoading extends AuthState {}

// สถานะเมื่อยืนยันตัวตนสำเร็จ
final class AuthSuccess extends AuthState {
  final String uid;
  const AuthSuccess(this.uid);
}

// สถานะเมื่อยืนยันตัวตนล้มเหลว
final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
