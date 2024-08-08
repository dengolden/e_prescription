import 'package:e_prescription/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String titleForm;
  final String hintForm;
  final bool obscureText;
  final TextEditingController controller;

  const CustomForm({
    required this.hintForm,
    required this.titleForm,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleForm,
          style: semiBoldTextStyle.copyWith(
            color: greenColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            obscureText: obscureText,
            style: regularTextStyle.copyWith(color: blackColor),
            cursorColor: greenColor,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: hintForm,
              hintStyle: regularTextStyle.copyWith(color: greyColor),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
