import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

// ปุ่มไล่สีที่ใช้ซ้ำได้
class AuthGradientButton extends StatelessWidget {
  // ข้อความที่แสดงบนปุ่ม
  final String bunttonText;
  // ฟังก์ชันที่เรียกเมื่อผู้ใช้กดปุ่ม
  final VoidCallback onPressed;

  const AuthGradientButton({
    super.key,
    required this.bunttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // ไล่สีจากล่างซ้ายไปบนขวา
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            // เพิ่ม AppPallete.gradient3 ตรงนี้ได้หากต้องการสีส้มพีช
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(500, 55),
          // ทำพื้นปุ่มโปร่งใสเพื่อให้เห็นสีไล่ระดับของ Container
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          bunttonText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
