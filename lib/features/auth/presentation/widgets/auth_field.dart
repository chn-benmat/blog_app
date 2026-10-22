import 'package:flutter/material.dart';

// ช่องกรอกที่ใช้ซ้ำ
class AuthField extends StatelessWidget {
  // ข้อความบอกว่าช่องนี้ให้กรอกอะไร และใช้ในข้อความเตือนเมื่อเว้นว่าง
  final String hintText;
  // ให้หน้าจออ่านหรือเปลี่ยนข้อความในช่องกรอกได้
  final TextEditingController controller;
  // กำหนดว่าจะซ่อนข้อความหรือไม่ เช่น ช่องรหัสผ่าน
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      // ช่องว่างถือว่ายังไม่ได้กรอก
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hintText is missing";
        }
        // คืน null เมื่อตรวจผ่าน เพื่อไม่แสดงข้อความผิดพลาด
        return null;
      },
      // ซ่อนข้อความเมื่อใช้เป็นช่องรหัสผ่าน
      obscureText: isObscureText,
      obscuringCharacter: "*",
    );
  }
}
