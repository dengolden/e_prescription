import 'package:e_prescription/pages/resep_form.dart';
import 'package:e_prescription/provider/resep_provider.dart';
import 'package:e_prescription/services/auth_service.dart';
import 'package:e_prescription/theme/theme.dart';
import 'package:e_prescription/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final AuthService authService;
  const HomeScreen({super.key, required this.authService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = widget.authService.getCurrentUser();
    if (user != null) {
      print('Current user ID: ${user.id}');
      final userProfile = await widget.authService.getUserProfile(user.id);
      if (mounted) {
        if (userProfile != null && userProfile.containsKey('name')) {
          print('User profile found: ${userProfile['name']}');
          setState(() {
            _userName = userProfile['name'];
            _isLoading = false;
          });
        } else {
          print('User profile not found or no name key present');
          setState(() {
            _userName = 'Unknown User';
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _userName = 'Unknown User';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => widget.authService.logout(context),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logout_icon.png',
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 200),
            Text(
              'Hai',
              style: regularTextStyle.copyWith(
                color: blackColor,
                fontSize: 20,
              ),
            ),
            _isLoading
                ? CustomLoading()
                : Text(
                    _userName!,
                    style: boldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 24,
                    ),
                  ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Provider.of<ResepProvider>(context, listen: false).resetResep();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResepForm()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 85,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Buat Resep',
                    style: semiBoldTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 23),
          ],
        ),
      ),
    );
  }
}
