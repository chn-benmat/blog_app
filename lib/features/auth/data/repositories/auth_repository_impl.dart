import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

// จัดการผลสมัครสมาชิกจาก Data source ให้เป็นข้อมูลผู้ใช้หรือข้อความผิดพลาด
class AuthRepositoryImpl implements AuthRepository {
  // ตัวติดต่อเซิร์ฟเวอร์สำหรับส่งข้อมูลสมัครสมาชิก
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: เพิ่มการเข้าสู่ระบบและคืนผลสำเร็จหรือล้มเหลว
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // ให้ Data source ติดต่อเซิร์ฟเวอร์เพื่อสมัครสมาชิก
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      // Right คือผลสำเร็จ พร้อมข้อมูลผู้ใช้ที่สมัครแล้ว
      return Right(user);
    } on ServerException catch (e) {
      // Left คือผลล้มเหลว พร้อมข้อความผิดพลาดให้ Bloc นำไปใช้
      return Left(Failure(e.message));
    }
  }
}
