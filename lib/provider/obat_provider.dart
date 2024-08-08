import 'package:e_prescription/models/obat.dart';
import 'package:flutter/material.dart';

class ObatProvider extends ChangeNotifier {
  List<Obat> _obatList = [];

  List<Obat> get obatList => _obatList;

  void addObat(Obat obat) {
    _obatList.add(obat);
    notifyListeners();
  }

  void removeObat(int index) {
    if (index >= 0 && index < _obatList.length) {
      _obatList.removeAt(index);
      notifyListeners();
    }
  }
}
