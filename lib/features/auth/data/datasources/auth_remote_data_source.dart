import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// กำหนดการสมัครสมาชิก เข้าสู่ระบบ และอ่านผู้ใช้จาก session ปัจจุบัน
abstract interface class AuthRemoteDataSource {
  // คืน session ที่ Supabase เก็บอยู่ หรือ null หากไม่มี session
  Session? get currentUserSession;
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

  // อ่านโปรไฟล์ของผู้ใช้ใน session หรือคืน null หากไม่มี session
  Future<UserModel?> getCurrentUserData();
}

// ส่งคำขอไปยัง Supabase และคืนข้อมูลผู้ใช้ในรูปแบบ UserModel
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // ใช้บริการยืนยันตัวตนและอ่านข้อมูลโปรไฟล์จาก Supabase
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        // ใช้ ID ใน session เพื่ออ่านข้อมูลผู้ใช้จากตาราง profiles
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        // ใช้อีเมลจาก session ประกอบกับข้อมูลโปรไฟล์ที่อ่านได้
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }

      // ไม่มี session จึงไม่มีผู้ใช้ปัจจุบันให้ดึงข้อมูล
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // ส่งอีเมลและรหัสผ่านไปเข้าสู่ระบบผ่าน Supabase
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
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
