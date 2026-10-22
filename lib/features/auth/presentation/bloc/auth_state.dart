part of 'auth_bloc.dart';

// รวมสถานะที่ Bloc ส่งให้หน้าจอ เพื่อเลือกว่าจะแสดงอะไร
@immutable
sealed class AuthState {
  const AuthState();
}

// เริ่มต้นก่อนมีคำขอยืนยันตัวตน
final class AuthInitial extends AuthState {}

// กำลังรอผลสมัครสมาชิก ให้หน้าจอแสดงตัวโหลด
final class AuthLoading extends AuthState {}

// ทำรายการสำเร็จ พร้อมข้อมูลผู้ใช้สำหรับขั้นตอนถัดไป
final class AuthSuccess extends AuthState {
  // ข้อมูลผู้ใช้ที่ได้หลังทำรายการสำเร็จ
  final User user;
  const AuthSuccess(this.user);
}

// ทำรายการไม่สำเร็จ เก็บข้อความไว้ให้หน้าจอแจ้งผู้ใช้
final class AuthFailure extends AuthState {
  // ข้อความที่หน้าจอจะนำไปแสดงเมื่อทำรายการไม่สำเร็จ
  final String message;
  const AuthFailure(this.message);
}
