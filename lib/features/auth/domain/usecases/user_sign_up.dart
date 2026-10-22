import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

// ทำงานสมัครสมาชิก โดยรับข้อมูลจาก Bloc แล้วส่งต่อให้ Repository
class UserSignUp implements UseCase<User, UserSignUpParrams> {
  // Repository ที่ใช้ส่งคำขอสมัครสมาชิก
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParrams params) async {
    // ส่งชื่อ อีเมล และรหัสผ่าน แล้วคืนผลจาก Repository
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

// รวมข้อมูลที่ต้องใช้ในการสมัครสมาชิกหนึ่งครั้ง
class UserSignUpParrams {
  // อีเมล รหัสผ่าน และชื่อที่จะส่งไปสร้างบัญชี
  final String email;
  final String password;
  final String name;

  UserSignUpParrams({
    required this.email,
    required this.password,
    required this.name,
  });
}
