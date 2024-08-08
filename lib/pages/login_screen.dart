import 'package:e_prescription/services/auth_service.dart';
import 'package:e_prescription/theme/theme.dart';
import 'package:e_prescription/widgets/custom_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;

  const LoginScreen({super.key, required this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 70,
                    ),
                    child: Center(
                      child: Text(
                        'Selamat Datang, dok!',
                        style: boldTextStyle.copyWith(
                          fontSize: 30,
                          color: greenColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Image.asset(
                    'assets/login.png',
                    width: 250,
                  ),
                  SizedBox(height: 60),
                  Text(
                    'Masuk ke Akun Anda',
                    style: boldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomForm(
                    hintForm: 'Masukan email anda',
                    titleForm: 'Email',
                    controller: _emailController,
                  ),
                  SizedBox(height: 16),
                  CustomForm(
                    hintForm: 'Masukan kata sandi anda',
                    titleForm: 'Kata Sandi',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => widget.authService.login(
                      context,
                      _emailController.text,
                      _passwordController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: semiBoldTextStyle.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    child: Text(
                      'Masuk',
                      style: semiBoldTextStyle.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
