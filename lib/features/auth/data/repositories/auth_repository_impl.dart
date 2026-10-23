import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

// จัดการผลสมัครสมาชิกและเข้าสู่ระบบให้เป็นข้อมูลผู้ใช้หรือข้อผิดพลาด
class AuthRepositoryImpl implements AuthRepository {
  // ติดต่อเซิร์ฟเวอร์เพื่อสมัครสมาชิกและเข้าสู่ระบบ
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // ส่งคำขอเข้าสู่ระบบให้ Data source โดยใช้ _getUser จัดการผลลัพธ์
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    // ส่งคำขอสมัครสมาชิกให้ Data source โดยใช้ _getUser จัดการผลลัพธ์
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  // ใช้ร่วมกันทั้งสมัครสมาชิกและเข้าสู่ระบบ เพื่อแปลงผลเป็น Either
  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      // เรียกคำขอที่ส่งเข้ามาและรอข้อมูลผู้ใช้
      final user = await fn();
      // Right คือผลสำเร็จ พร้อมข้อมูลผู้ใช้
      return Right(user);
    } on sb.AuthException catch (e) {
      // แปลงข้อผิดพลาดยืนยันตัวตนของ Supabase เป็น Failure
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      // แปลงข้อผิดพลาดจาก Data source เป็น Failure
      return Left(Failure(e.message));
    }
  }
}
