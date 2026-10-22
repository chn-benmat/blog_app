// ใช้โยนข้อผิดพลาดจากการติดต่อเซิร์ฟเวอร์ให้ Repository จัดการ
class ServerException implements Exception {
  // รายละเอียดข้อผิดพลาดที่ส่งให้ Repository
  final String message;
  ServerException(this.message);
}
