// เก็บข้อมูลผู้ใช้ที่แอปต้องใช้ ได้แก่ รหัสผู้ใช้ ชื่อ และอีเมล
class User {
  // รหัสที่ใช้ระบุว่าเป็นผู้ใช้คนใด
  final String id;
  // ชื่อสำหรับแสดงในแอป
  final String name;
  // อีเมลของบัญชีผู้ใช้
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}
