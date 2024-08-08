import 'package:e_prescription/pages/auth_screen.dart';
import 'package:e_prescription/services/auth_service.dart';
import 'package:e_prescription/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = AuthService(Supabase.instance.client);
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(authService: authService),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Container(
        margin: EdgeInsets.only(top: 390),
        child: Center(
          child: Column(
            children: [
              Text(
                'E-Resep',
                style: boldTextStyle.copyWith(
                  fontSize: 30,
                  color: whiteColor,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Resep Digital Persada Bakti',
                style: regularTextStyle.copyWith(
                  fontSize: 18,
                  color: whiteColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
