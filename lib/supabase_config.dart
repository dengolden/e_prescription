import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://gamumisjjdwukgwqekht.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdhbXVtaXNqamR3dWtnd3Fla2h0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA0MTA1MjgsImV4cCI6MjAzNTk4NjUyOH0.i2goniey3F8c8AbohIG8SiuYGgv7l1YDeuBnhmisYh0';

  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
