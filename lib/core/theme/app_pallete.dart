import 'package:flutter/material.dart';

// เก็บสีที่ใช้ในแอปไว้ที่เดียว เพื่อเรียกใช้และแก้สีได้สะดวก
class AppPallete {
  // สีพื้นหลังดำอมม่วงเข้ม
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  // สีเริ่มต้นของพื้นหลังไล่ระดับ
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  // สีปลายของพื้นหลังไล่ระดับ และขอบช่องกรอกที่เลือก
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  // สีส้มพีชสำหรับเพิ่มในพื้นหลังไล่ระดับ
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  // สีขอบช่องกรอกขณะยังไม่ได้เลือก
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  // สีขาว
  static const Color whiteColor = Colors.white;
  // สีเทา
  static const Color greyColor = Colors.grey;
  // สีสำหรับแสดงข้อผิดพลาด
  static const Color errorColor = Colors.redAccent;
  // สีโปร่งใส
  static const Color transparentColor = Colors.transparent;
}
