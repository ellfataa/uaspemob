class Barang {
  String namaBarang;
  int hargaBarang;

  Barang({
    required this.namaBarang,
    required this.hargaBarang,
  });

  // Fungsi untuk mengonversi objek Barang ke dalam format JSON
  Map<String, dynamic> toJson() {
    return {
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang,
    };
  }

  // Fungsi untuk membuat objek Barang dari JSON
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      namaBarang: json['nama_barang'],
      hargaBarang: json['harga_barang'],
    );
  }
}
