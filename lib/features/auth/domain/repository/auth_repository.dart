import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

// กำหนดว่าคลาสจัดการข้อมูลผู้ใช้ต้องสมัครสมาชิกและเข้าสู่ระบบได้
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
}
