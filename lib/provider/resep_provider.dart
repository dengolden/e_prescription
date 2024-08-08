import 'package:e_prescription/models/obat.dart';
import 'package:e_prescription/models/resep.dart';
import 'package:flutter/material.dart';

class ResepProvider with ChangeNotifier {
  Resep _resep = Resep(
    noResep: '',
    namaPasien: '',
    jenisKelamin: '',
    umur: '',
    satuanUmur: 'Tahun',
    alamat: '',
    jenisPasien: 'Umum III',
    obatList: [],
    createdAt: '',
  );

  Resep get resep => _resep;

  void resetResep() {
    _resep = Resep(
      noResep: '',
      namaPasien: '',
      jenisKelamin: '',
      umur: '',
      satuanUmur: 'Tahun',
      alamat: '',
      jenisPasien: 'Umum III',
      obatList: [],
      createdAt: '',
    );
    notifyListeners();
  }

  void updateNoResep(String value) {
    _resep.noResep = value;
    notifyListeners();
  }

  void updateNamaPasien(String value) {
    _resep.namaPasien = value;
    notifyListeners();
  }

  void updateJenisKelamin(String value) {
    _resep.jenisKelamin = value;
    notifyListeners();
  }

  void updateUmur(String value) {
    _resep.umur = value;
    notifyListeners();
  }

  void updateSatuanUmur(String value) {
    _resep.satuanUmur = value;
    notifyListeners();
  }

  void updateAlamat(String value) {
    _resep.alamat = value;
    notifyListeners();
  }

  void updateJenisPasien(String value) {
    _resep.jenisPasien = value;
    notifyListeners();
  }

  void addObat(Obat obat) {
    _resep.obatList.add(obat);
    notifyListeners();
  }

  void removeObat(int index) {
    if (index >= 0 && index < _resep.obatList.length) {
      _resep.obatList.removeAt(index);
      notifyListeners();
    }
  }

  void updateObat(int index, Obat obat) {
    if (index >= 0 && index < _resep.obatList.length) {
      _resep.obatList[index] = obat;
      notifyListeners();
    }
  }
}
