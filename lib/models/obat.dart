class Obat {
  String nama;
  String jumlah;
  String dosis;

  Obat({required this.nama, required this.jumlah, required this.dosis});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      nama: json['name'],
      jumlah: json['quantity'],
      dosis: json['dosage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nama,
      'quantity': jumlah,
      'dosage': dosis,
    };
  }
}
