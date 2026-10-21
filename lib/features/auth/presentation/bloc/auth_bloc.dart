import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// จัดการ Event และ State ของระบบยืนยันตัวตน
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  }) : _userSignUp = userSignUp,
       super(AuthInitial()) {
    // จัดการการสมัครสมาชิก
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp(
        UserSignUpParrams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      // อัปเดตสถานะตามผลลัพธ์
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (uid) => emit(AuthSuccess(uid)),
      );
    });
  }
}
