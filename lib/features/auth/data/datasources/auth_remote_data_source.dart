import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// กำหนดการสมัครสมาชิกและเข้าสู่ระบบที่ Data source ต้องรองรับ
abstract interface class AuthRemoteDataSource {
  // สมัครสมาชิกและคืนข้อมูลผู้ใช้จากเซิร์ฟเวอร์
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  // เข้าสู่ระบบและคืนข้อมูลผู้ใช้จากเซิร์ฟเวอร์
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

// ส่งคำขอไปยัง Supabase และคืนข้อมูลผู้ใช้ในรูปแบบ UserModel
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // ใช้เรียกบริการสมัครสมาชิกและเข้าสู่ระบบของ Supabase
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: เพิ่มการเข้าสู่ระบบผ่าน Supabase
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // ส่งอีเมลและรหัสผ่านไปสมัครสมาชิก พร้อมบันทึกชื่อเป็นข้อมูลเสริมของผู้ใช้
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      // หากไม่มีผู้ใช้ ให้ถือว่าคำขอนี้ล้มเหลว
      if (response.user == null) {
        throw ServerException('User is null');
      }

      // นำข้อมูลผู้ใช้ที่ Supabase ส่งกลับมาสร้าง UserModel
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      // เปลี่ยนข้อผิดพลาดเป็น ServerException เพื่อให้ Repository จับได้
      throw ServerException(e.toString());
    }
  }
}
