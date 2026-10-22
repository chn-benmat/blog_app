import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ตัวจัดการ Dependencies
final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // ลงทะเบียน Dependencies ของระบบ Auth
  _initAuth();

  // โหลดค่าจากไฟล์ Environment
  await dotenv.load(fileName: '.env.local');

  // เริ่มต้นการเชื่อมต่อ Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    publishableKey: AppSecrets.supabasePublishableKey,
  );

  // ลงทะเบียน Supabase Client
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // จัดการการเชื่อมต่อข้อมูล Auth
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  // จัดการ Repository ของ Auth
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  // จัดการ Use Case สมัครสมาชิก
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  // จัดการสถานะ Auth ด้วย Bloc
  serviceLocator.registerSingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
