// เก็บข้อผิดพลาดที่ Repository ส่งกลับให้ Bloc แจ้งหน้าจอ
class Failure {
  final String message;
  // ใช้ข้อความเริ่มต้นเมื่อไม่ได้ระบุรายละเอียดข้อผิดพลาด
  Failure([this.message = 'An error occurred']);
}
