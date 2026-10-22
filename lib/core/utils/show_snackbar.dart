import 'package:flutter/material.dart';

// แสดง content เป็นข้อความด้านล่างหน้าจอ โดยซ่อนข้อความเดิมก่อน
void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}
