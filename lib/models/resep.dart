import 'package:e_prescription/models/obat.dart';

class Resep {
  String noResep;
  String namaPasien;
  String jenisKelamin;
  String umur;
  String satuanUmur;
  String alamat;
  String jenisPasien;
  List<Obat> obatList;
  String createdAt;

  Resep({
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
}
