class Barang {
  final int idBarang;
  final String namaBarang;
  final int hargaBarang;

  Barang({
    required this.idBarang,
    required this.namaBarang,
    required this.hargaBarang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      idBarang: int.parse(json['id_barang']),
      namaBarang: json['nama_barang'],
      hargaBarang: int.parse(json['harga_barang']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_barang': idBarang.toString(),
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang.toString(),
    };
  }
}

