import 'package:blog_app/features/auth/domain/entities/user.dart';

// สร้างข้อมูลผู้ใช้จาก Map ที่ได้รับจากเซิร์ฟเวอร์ เพื่อนำไปใช้ในแอป
class UserModel extends User {
  // รับข้อมูลผู้ใช้แล้วส่งให้ User เก็บไว้
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  // แปลงข้อมูลเป็น UserModel โดยใช้ข้อความว่างหากไม่พบค่าหรือค่าเป็น null
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  // สร้างข้อมูลผู้ใช้ชุดใหม่ โดยคงค่าเดิมในช่องที่ไม่ได้ส่งค่าหรือส่ง null
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
