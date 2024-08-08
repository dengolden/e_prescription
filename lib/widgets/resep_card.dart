import 'package:e_prescription/theme/theme.dart';
import 'package:flutter/material.dart';

class ResepCard extends StatelessWidget {
  final String patientName;
  final String gender;
  final int age;
  final String type;
  const ResepCard({
    required this.patientName,
    required this.gender,
    required this.age,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 134,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: mediumTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 18,
                ),
              ),
              Text(
                '$gender, $age Tahun',
                style: regularTextStyle.copyWith(
                  color: blackColor.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 33),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: highlightBlueColor,
                ),
                child: Text(
                  'BPJS',
                  style: boldTextStyle.copyWith(
                    color: blueColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 174,
            height: 38,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: greenColor,
            ),
            child: Row(
              children: [
                Text(
                  'Lihat Selengkapnya',
                  style: semiBoldTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 4),
                Image.asset(
                  'assets/arrow_icon.png',
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
