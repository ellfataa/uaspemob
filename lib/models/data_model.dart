class Barang {
  String namaBarang;
  int hargaBarang;

  Barang({
    required this.namaBarang,
    required this.hargaBarang,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang,
    };
  }

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      namaBarang: json['nama_barang'],
      hargaBarang: json['harga_barang'],
    );
  }
}
