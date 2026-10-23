import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  // สร้างเส้นทางสำหรับนำทางไปยังหน้าเข้าสู่ระบบ
  static MaterialPageRoute<void> route() => MaterialPageRoute(
    builder: (context) => const LoginPage(),
  );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// เก็บค่าช่องกรอกและสร้างฟอร์มเข้าสู่ระบบ
class _LoginPageState extends State<LoginPage> {
  // ใช้อ่านอีเมลและรหัสผ่านที่ผู้ใช้กรอก
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // ใช้ตรวจทุกช่องในฟอร์มก่อนส่งข้อมูลเข้าสู่ระบบ
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // คืนทรัพยากรของช่องกรอกเมื่อหน้านี้ถูกปิด
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          // แจ้งข้อผิดพลาดเมื่อสถานะเปลี่ยน
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          // แสดงตัวโหลดระหว่างรอผล แล้วแสดงฟอร์มในสถานะอื่น
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In.",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    bunttonText: "Sign In",
                    onPressed: () {
                      // ตรวจฟอร์มก่อนตัดช่องว่างหัวท้ายและส่งเหตุการณ์เข้าสู่ระบบ
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // เมื่อผู้ใช้แตะจะนำทางไปยังหน้าสมัครสมาชิก
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
