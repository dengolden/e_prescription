import 'package:e_prescription/models/obat.dart';
import 'package:e_prescription/pages/resep_screen.dart';
import 'package:e_prescription/provider/resep_provider.dart';
import 'package:e_prescription/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResepForm extends StatefulWidget {
  const ResepForm({super.key});

  @override
  State<ResepForm> createState() => _ResepFormState();
}

class _ResepFormState extends State<ResepForm> {
  void _addObatForm() {
    Provider.of<ResepProvider>(context, listen: false).addObat(
      Obat(nama: '', jumlah: '', dosis: ''),
    );
  }

  void _submitForm() {
    final resepProvider = Provider.of<ResepProvider>(context, listen: false);
    resepProvider.resep.createdAt = DateTime.now().toUtc().toIso8601String();

    resepProvider.resep.obatList.forEach((obat) {
      print('Nama: ${obat.nama}, Jumlah: ${obat.jumlah}, Dosis: ${obat.dosis}');
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResepScreen(
          noResep: resepProvider.resep.noResep,
          namaPasien: resepProvider.resep.namaPasien,
          jenisKelamin: resepProvider.resep.jenisKelamin,
          umur: resepProvider.resep.umur,
          satuanUmur: resepProvider.resep.satuanUmur,
          alamat: resepProvider.resep.alamat,
          jenisPasien: resepProvider.resep.jenisPasien,
          obatList: resepProvider.resep.obatList
              .map((obat) => {
                    'nama': obat.nama,
                    'jumlah': obat.jumlah,
                    'dosis': obat.dosis
                  })
              .toList(),
          createdAt: resepProvider.resep.createdAt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resepProvider = Provider.of<ResepProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.only(
          top: 60,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(width: 90),
                  Text(
                    'Buat Resep',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No.Resep',
                      style: semiBoldTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      style: mediumTextStyle.copyWith(color: blackColor),
                      cursorColor: greenColor,
                      initialValue: resepProvider.resep.noResep,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        resepProvider.updateNoResep(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    Divider()
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Informasi Pasien',
                style: semiBoldTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pasien',
                      style: semiBoldTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      initialValue: resepProvider.resep.namaPasien,
                      style: mediumTextStyle.copyWith(color: blackColor),
                      cursorColor: greenColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        resepProvider.updateNamaPasien(value);
                      },
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: semiBoldTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              activeColor: greenColor,
                              value: 'Laki-laki',
                              groupValue: resepProvider.resep.jenisKelamin,
                              onChanged: (value) {
                                resepProvider.updateJenisKelamin(value!);
                              },
                            ),
                            Text(
                              'Laki-laki',
                              style:
                                  mediumTextStyle.copyWith(color: blackColor),
                            ),
                            SizedBox(width: 20),
                            Radio<String>(
                              activeColor: greenColor,
                              value: 'Perempuan',
                              groupValue: resepProvider.resep.jenisKelamin,
                              onChanged: (value) {
                                resepProvider.updateJenisKelamin(value!);
                              },
                            ),
                            Text(
                              'Perempuan',
                              style:
                                  mediumTextStyle.copyWith(color: blackColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Umur',
                                    style: semiBoldTextStyle.copyWith(
                                      color: blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: resepProvider.resep.umur,
                                    style: mediumTextStyle.copyWith(
                                        color: blackColor),
                                    cursorColor: greenColor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      resepProvider.updateUmur(value);
                                    },
                                  ),
                                  Divider(endIndent: 200),
                                ],
                              ),
                            ),
                            DropdownButton<String>(
                              value: resepProvider.resep.satuanUmur,
                              items: ['Tahun', 'Bulan'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                resepProvider.updateSatuanUmur(newValue!);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Alamat',
                          style: semiBoldTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          initialValue: resepProvider.resep.alamat,
                          style: mediumTextStyle.copyWith(color: blackColor),
                          cursorColor: greenColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            resepProvider.updateAlamat(value);
                          },
                        ),
                        Divider(),
                        SizedBox(height: 20),
                        Text(
                          'Keterangan',
                          style: semiBoldTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                          ),
                        ),
                        DropdownButton<String>(
                          value: resepProvider.resep.jenisPasien,
                          items: [
                            'Umum III',
                            'Umum IV',
                            'Umum V',
                            'BPJS',
                            'Free'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    mediumTextStyle.copyWith(color: blackColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            resepProvider.updateJenisPasien(newValue!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Informasi Obat',
                style: semiBoldTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Consumer<ResepProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children:
                        provider.resep.obatList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Obat obat = entry.value;
                      return _buildObatForm(index, obat);
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: _addObatForm,
                child: Container(
                  width: 151,
                  height: 38,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Tambah obat',
                      style: semiBoldTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: _submitForm,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Buat Resep',
                      style: semiBoldTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildObatForm(int index, Obat obat) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<ResepProvider>(context, listen: false)
                      .removeObat(index);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Color(0xffFB5656),
                  size: 24,
                ),
              ),
              Text(
                'Obat ke: ${index + 1}',
                style: mediumTextStyle.copyWith(color: greenColor),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Nama Obat',
            style: semiBoldTextStyle.copyWith(
              color: blackColor,
              fontSize: 16,
            ),
          ),
          TextFormField(
            style: mediumTextStyle.copyWith(color: blackColor),
            initialValue: obat.nama,
            cursorColor: greenColor,
            onChanged: (value) {
              Provider.of<ResepProvider>(context, listen: false).updateObat(
                  index,
                  Obat(nama: value, jumlah: obat.jumlah, dosis: obat.dosis));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          Divider(),
          SizedBox(height: 20),
          Text(
            'Jumlah',
            style: semiBoldTextStyle.copyWith(
              color: blackColor,
              fontSize: 16,
            ),
          ),
          TextFormField(
            style: mediumTextStyle.copyWith(color: blackColor),
            cursorColor: greenColor,
            initialValue: obat.jumlah,
            onChanged: (value) {
              Provider.of<ResepProvider>(context, listen: false).updateObat(
                  index,
                  Obat(nama: obat.nama, jumlah: value, dosis: obat.dosis));
            },
            decoration: InputDecoration(
              hintText: 'Contoh: No X',
              hintStyle: regularTextStyle.copyWith(
                color: blackColor.withOpacity(0.5),
              ),
              border: InputBorder.none,
            ),
          ),
          Divider(),
          SizedBox(height: 20),
          Text(
            'Dosis',
            style: semiBoldTextStyle.copyWith(
              color: blackColor,
              fontSize: 16,
            ),
          ),
          TextFormField(
            style: mediumTextStyle.copyWith(color: blackColor),
            cursorColor: greenColor,
            initialValue: obat.dosis,
            onChanged: (value) {
              Provider.of<ResepProvider>(context, listen: false).updateObat(
                  index,
                  Obat(nama: obat.nama, jumlah: obat.jumlah, dosis: value));
            },
            decoration: InputDecoration(
              hintText: 'Contoh: 2 x 1 Sesudah Makan',
              hintStyle: regularTextStyle.copyWith(
                color: blackColor.withOpacity(0.5),
              ),
              border: InputBorder.none,
            ),
          ),
          Divider(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
