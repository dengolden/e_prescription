import 'dart:io';
import 'package:e_prescription/pages/home_screen.dart';
import 'package:e_prescription/services/auth_service.dart';
import 'package:e_prescription/services/db_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:e_prescription/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ResepScreen extends StatefulWidget {
  final String noResep;
  final String namaPasien;
  final String jenisKelamin;
  final String umur;
  final String satuanUmur;
  final String alamat;
  final String jenisPasien;
  final List<Map<String, String>> obatList;
  final String createdAt;

  ResepScreen({
    required this.noResep,
    required this.namaPasien,
    required this.jenisKelamin,
    required this.umur,
    required this.satuanUmur,
    required this.alamat,
    required this.jenisPasien,
    required this.obatList,
    required this.createdAt,
  });

  @override
  State<ResepScreen> createState() => _ResepScreenState();
}

class _ResepScreenState extends State<ResepScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _captureScreenshot() async {
    // Mengambil screenshot
    final image = await screenshotController.capture();
    if (image != null) {
      final result =
          await ImageGallerySaver.saveImage(image, name: "resep_digital");
      print("Captured image: $result");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resep berhasil disimpan di galeri!')),
      );
    }
  }

  Future<void> _shareScreenshot() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final imagePath =
          await File('${directory.path}/resep_digital.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([XFile(imagePath.path)], text: 'Ada resep baru!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 60,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/back_icon.png',
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 70),
                  Center(
                    child: Text(
                      'Resep Digital',
                      style: semiBoldTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              FutureBuilder<Map<String, dynamic>?>(
                future: _getUserProfile(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print('Snapshot error: ${snapshot.error}');
                    return Text('Error loading user data');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text('No user data found');
                  } else {
                    return Screenshot(
                      controller: screenshotController,
                      child: _resepDigitalCard(snapshot.data!),
                    );
                  }
                },
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _captureScreenshot,
                        child: Container(
                          width: 170,
                          height: 55,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Unduh',
                              style: boldTextStyle.copyWith(
                                color: whiteColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _shareScreenshot,
                        child: Container(
                          width: 170,
                          height: 55,
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Bagikan',
                              style: boldTextStyle.copyWith(
                                color: whiteColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(authService: authService),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greenColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Kembali ke Beranda',
                          style: boldTextStyle.copyWith(
                            color: greenColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _getUserProfile(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final dbService = Provider.of<DbService>(context, listen: false);
    final user = authService.getCurrentUser();
    if (user != null) {
      return dbService.getUserNameAndSip(user.id);
    }
    return null;
  }

  Widget _resepDigitalCard(Map<String, dynamic> userData) {
    final createdAtDate = DateTime.parse(widget.createdAt);
    final formattedDate =
        '${createdAtDate.day.toString().padLeft(2, '0')}/${createdAtDate.month.toString().padLeft(2, '0')}/${createdAtDate.year}';
    Color _getJenisPasienColor(String jenisPasien) {
      switch (jenisPasien) {
        case 'BPJS':
          return blueColor;
        case 'Free':
          return Color(0xffEAAC0C);
        case 'Umum III':
        case 'Umum IV':
        case 'Umum V':
          return greenColor;
        default:
          return Colors.black;
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apotik 24 Jam PB Farma',
            style: boldTextStyle.copyWith(
              color: blackColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Jln. Sudirman, Kel. Sarotari Timur, Larantuka',
            style: mediumTextStyle.copyWith(
              color: blackColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: greenColor,
          ),
          SizedBox(height: 10),
          Text(
            userData['name'],
            style: semiBoldTextStyle.copyWith(
              color: blackColor,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 3),
          Text(
            userData['sip'],
            style: semiBoldTextStyle.copyWith(
              color: blackColor.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: greenColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R/',
                style: boldTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 11),
                    decoration: BoxDecoration(
                      color: _getJenisPasienColor(widget.jenisPasien)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.jenisPasien}',
                        style: semiBoldTextStyle.copyWith(
                          color: _getJenisPasienColor(widget.jenisPasien),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'No: ${widget.noResep}',
                    style: mediumTextStyle.copyWith(
                      fontSize: 13,
                      color: blackColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: mediumTextStyle.copyWith(
                      fontSize: 13,
                      color: blackColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          ...widget.obatList.map((obat) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${obat['nama']}',
                  style: semiBoldTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${obat['jumlah']}',
                  style: semiBoldTextStyle.copyWith(
                    color: blackColor.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${obat['dosis']}',
                  style: semiBoldTextStyle.copyWith(
                    color: blackColor.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          Divider(color: greenColor),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Pasien',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.namaPasien,
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jenis Kelamin',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.jenisKelamin,
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Usia',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.umur} ${widget.satuanUmur}',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alamat',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.alamat,
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
