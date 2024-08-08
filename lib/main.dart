import 'package:e_prescription/pages/splash_screen.dart';
import 'package:e_prescription/provider/obat_provider.dart';
import 'package:e_prescription/provider/pasien_provider.dart';
import 'package:e_prescription/provider/resep_provider.dart';
import 'package:e_prescription/services/auth_service.dart';
import 'package:e_prescription/services/db_service.dart';
import 'package:e_prescription/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObatProvider()),
        ChangeNotifierProvider(create: (_) => PasienProvider()),
        ChangeNotifierProvider(create: (_) => ResepProvider()),
        Provider(create: (_) => AuthService(Supabase.instance.client)),
        Provider(create: (_) => DbService(Supabase.instance.client)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
    );
  }
}
