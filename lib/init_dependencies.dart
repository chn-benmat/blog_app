import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// เก็บวิธีสร้างคลาส เพื่อให้ส่วนอื่นเรียกใช้ผ่าน serviceLocator ได้
final serviceLocator = GetIt.instance;

// ลงทะเบียนคลาส โหลดค่าตั้งค่า และเตรียม Supabase ก่อนเปิดแอป
Future<void> initDependencies() async {
  // ลงทะเบียนวิธีสร้างคลาส Auth โดยยังไม่สร้างทันที
  _initAuth();

  // โหลด .env.local ก่อนอ่านค่าการเชื่อมต่อ
  await dotenv.load(fileName: '.env.local');

  // เริ่มต้นการเชื่อมต่อ Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    publishableKey: AppSecrets.supabasePublishableKey,
  );

  // เก็บวิธีเรียก Supabase Client เพื่อให้คลาสอื่นใช้ตัวเดียวกัน
  serviceLocator.registerLazySingleton(() => supabase.client);
}

// ลงทะเบียนวิธีสร้างคลาสสมัครสมาชิก พร้อมคลาสที่แต่ละตัวต้องใช้
void _initAuth() {
  // สร้าง Data source ใหม่เมื่อเรียกใช้ พร้อมส่ง Supabase Client ให้
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  // สร้าง Repository ใหม่เมื่อเรียกใช้ พร้อมส่ง Data source ให้
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  // สร้าง Use case ใหม่เมื่อเรียกใช้ พร้อมส่ง Repository ให้
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  // สร้าง AuthBloc ครั้งแรกที่เรียกใช้ แล้วใช้ตัวเดิมร่วมกัน
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
