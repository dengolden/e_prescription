import 'package:e_prescription/models/pasien.dart';
import 'package:flutter/material.dart';

class PasienProvider extends ChangeNotifier {
  Pasien _pasien = Pasien(
    nama: '',
    jenisKelamin: 'Pria',
    umur: '',
    alamat: '',
    jenisPasien: 'BPJS',
  );

  Pasien get pasien => _pasien;

  void updateNama(String nama) {
    _pasien.nama = nama;
    notifyListeners();
  }

  void updateJenisKelamin(String jenisKelamin) {
    _pasien.jenisKelamin = jenisKelamin;
    notifyListeners();
  }

  void updateUmur(String umur) {
    _pasien.umur = umur;
    notifyListeners();
  }

  void updateAlamat(String alamat) {
    _pasien.alamat = alamat;
    notifyListeners();
  }

  void updateJenisPasien(String jenisPasien) {
    _pasien.jenisPasien = jenisPasien;
    notifyListeners();
  }
}
