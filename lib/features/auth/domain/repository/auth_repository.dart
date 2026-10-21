import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // function สำหรับการลงทะเบียนผู้ใช้ด้วยอีเมลและรหัสผ่าน
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  // function สำหรับการเข้าสู่ระบบผู้ใช้ด้วยอีเมลและรหัสผ่าน
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
