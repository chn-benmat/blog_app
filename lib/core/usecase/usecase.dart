import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

// รับ Params แล้วคืนผลไม่สำเร็จ (Failure) หรือผลสำเร็จ (SuccessType)
abstract interface class UseCase<SuccessType, Params> {
  // เรียกงานด้วย params และรอผลสำเร็จหรือข้อผิดพลาด
  Future<Either<Failure, SuccessType>> call(Params params);
}
