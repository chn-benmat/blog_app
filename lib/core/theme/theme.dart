import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

// กำหนดสีพื้นหลัง แถบด้านบน และรูปแบบช่องกรอกให้ใช้เหมือนกันทั้งแอป
class AppTheme {
  // ใช้รูปทรงขอบเดียวกัน โดยเปลี่ยนสีตามสถานะของช่องกรอก
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  // กำหนดสีพื้นหลังและรูปแบบช่องกรอกของธีมมืด
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
