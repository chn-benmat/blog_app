import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

// แสดงช่องอีเมล รหัสผ่าน และทางไปหน้าสมัครสมาชิก
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
  // เตรียมไว้ตรวจข้อมูลใน Form แต่หน้านี้ยังไม่ได้เชื่อมกับ Form
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
              onPressed: () {},
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      ),
    );
  }
}
