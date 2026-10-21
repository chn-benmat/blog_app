import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // เตรียม Flutter ก่อนเริ่มทำงานแบบ Async
  WidgetsFlutterBinding.ensureInitialized();

  // โหลด Environment Variables
  await dotenv.load(fileName: '.env.local');

  // เชื่อมต่อกับ Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    publishableKey: AppSecrets.supabasePublishableKey,
  );

  // เริ่มต้นแอปและกำหนด Bloc ที่ใช้งานร่วมกัน
  runApp(
    MultiBlocProvider(
      providers: [
        // กำหนด AuthBloc พร้อม Dependencies สำหรับสมัครสมาชิก
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              AuthRepositoryImpl(AuthRemoteDataSourceImpl(supabase.client)),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // กำหนดการตั้งค่าและหน้าเริ่มต้นของแอป
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
