import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

// รับ Params แล้วคืนผลไม่สำเร็จ (Failure) หรือผลสำเร็จ (SuccessType)
abstract interface class UseCase<SuccessType, Params> {
  // เรียกงานด้วย params และรอผลสำเร็จหรือข้อผิดพลาด
  Future<Either<Failure, SuccessType>> call(Params params);
}

// ใช้กับ Use case ที่ไม่ต้องรับข้อมูล เช่น การอ่านผู้ใช้จาก session ปัจจุบัน
class NoParams {}
