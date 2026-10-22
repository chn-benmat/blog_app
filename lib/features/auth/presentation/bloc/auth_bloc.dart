import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// จัดการคำสั่งสมัครสมาชิก และส่งสถานะกลับให้หน้าจอแสดงผล
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ใช้เรียกสมัครสมาชิกเมื่อได้รับคำสั่ง AuthSignUp
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  }) : _userSignUp = userSignUp,
       super(AuthInitial()) {
    // รับเหตุการณ์สมัครสมาชิกจากหน้าจอ
    on<AuthSignUp>((event, emit) async {
      // ให้หน้าจอแสดงตัวโหลดระหว่างรอผล
      emit(AuthLoading());
      // ส่งข้อมูลให้ Use case ดำเนินการสมัครสมาชิก
      final res = await _userSignUp(
        UserSignUpParrams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      // ถ้าล้มเหลวส่งข้อความผิดพลาด ถ้าสำเร็จส่งข้อมูลผู้ใช้ให้หน้าจอ
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });
  }
}
