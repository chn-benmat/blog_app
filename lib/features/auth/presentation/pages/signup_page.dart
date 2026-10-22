import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// แสดงฟอร์มสมัครสมาชิก ส่งข้อมูลให้ Bloc และแสดงผลระหว่างรอหรือเมื่อผิดพลาด
class SignUpPage extends StatefulWidget {
  // สร้างเส้นทางสำหรับนำทางไปยังหน้าสมัครสมาชิก
  static MaterialPageRoute<void> route() => MaterialPageRoute(
    builder: (context) => const SignUpPage(),
  );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

// เก็บค่าฟอร์มและแสดงหน้าจอตามสถานะจาก Bloc
class _SignUpPageState extends State<SignUpPage> {
  // ใช้อ่านค่าที่ผู้ใช้กรอกในแต่ละช่อง
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  // ใช้เรียกตรวจสอบทุกช่องในฟอร์มก่อนส่งข้อมูล
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // คืนทรัพยากรของช่องกรอกเมื่อออกจากหน้านี้
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          // แจ้งข้อผิดพลาดเมื่อสถานะเปลี่ยน
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          // แสดงตัวโหลดระหว่างรอผล แล้วกลับมาแสดงฟอร์มในสถานะอื่น
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
                    "Sign Up.",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: "Name",
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
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
                    bunttonText: "Sign Up",
                    onPressed: () {
                      // ตรวจทุกช่องก่อนตัดช่องว่างหัวท้ายและส่งเหตุการณ์สมัครสมาชิก
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // เมื่อผู้ใช้แตะจะนำทางไปยังหน้าเข้าสู่ระบบ
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign In",
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
