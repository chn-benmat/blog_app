import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  // function สำหรับการลงทะเบียนผู้ใช้ด้วยอีเมลและรหัสผ่าน
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  // function สำหรับการเข้าสู่ระบบผู้ใช้ด้วยอีเมลและรหัสผ่าน
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // สมัครสมาชิกผ่าน Supabase
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      // ตรวจสอบว่ามีข้อมูลผู้ใช้หรือไม่
      if (response.user == null) {
        throw ServerException('User is null');
      }

      // ส่งคืน ID ของผู้ใช้
      return response.user!.id;
    } catch (e) {
      // จัดการข้อผิดพลาด
      throw ServerException(e.toString());
    }
  }
}
