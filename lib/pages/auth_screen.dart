import 'package:e_prescription/pages/home_screen.dart';
import 'package:e_prescription/pages/login_screen.dart';
import 'package:e_prescription/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatelessWidget {
  final AuthService authService;

  const AuthScreen({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data?.session != null) {
          return HomeScreen(authService: authService);
        } else {
          return LoginScreen(authService: authService);
        }
      },
    );
  }
}
