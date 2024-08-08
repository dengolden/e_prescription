import 'package:e_prescription/pages/home_screen.dart';
import 'package:e_prescription/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService(this._client);

  Future<void> login(
      BuildContext context, String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            authService: this,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unknown error'),
      ));
    }
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final response =
        await _client.from('users').select('name').eq('uid', uid).maybeSingle();

    if (response == null) {
      print('No profile found for UID: $uid');
      return null;
    }
    print('Profile found: $response');

    return response;
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Future<void> logout(BuildContext context) async {
    await _client.auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          authService: this,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
