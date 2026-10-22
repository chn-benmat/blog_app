import 'package:flutter/material.dart';

// แสดงวงกลมหมุนกลางหน้าจอ เพื่อบอกว่ากำลังรอข้อมูล
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
