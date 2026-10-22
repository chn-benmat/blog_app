import 'package:flutter_dotenv/flutter_dotenv.dart';

// รวมค่าที่ใช้เชื่อมต่อ Supabase โดยอ่านจากไฟล์ .env ตั้งค่าที่โหลดไว้
class AppSecrets {
  // ที่อยู่โปรเจกต์ Supabase ที่แอปจะเชื่อมต่อ
  static String get supabaseUrl => dotenv.get('SUPABASE_URL');
  // คีย์สำหรับเชื่อมต่อโปรเจกต์ Supabase จากแอป
  static String get supabasePublishableKey =>
      dotenv.get('SUPABASE_PUBLISHABLE_KEY');
}
