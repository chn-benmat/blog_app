import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

// กำหนดการสมัครสมาชิก เข้าสู่ระบบ และอ่านข้อมูลผู้ใช้ปัจจุบัน
abstract interface class AuthRepository {
  // สมัครสมาชิกแล้วคืน Failure (ล้มเหลว) หรือ User (สำเร็จ)
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  // เข้าสู่ระบบแล้วคืน Failure (ล้มเหลว) หรือ User (สำเร็จ)
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  // คืนผู้ใช้จาก session ปัจจุบัน หรือ Failure หากไม่มีผู้ใช้หรือเกิดข้อผิดพลาด
  Future<Either<Failure, User>> curentUser();
}
