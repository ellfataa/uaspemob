import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../models/data_model.dart';

class DataView extends StatefulWidget {
  @override
  _DataViewState createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  final DataController dataController = Get.put(DataController());
  final List<Map<String, TextEditingController>> _items = [];
  int totalHarga = 0; // Menyimpan total harga barang

  @override
  void initState() {
    super.initState();
    _addItem(); // Tambahkan input pertama ketika halaman dibuka
  }

  void _addItem() {
    setState(() {
      _items.add({
        'nama_barang': TextEditingController(),
        'harga_barang': TextEditingController(),
      });
    });
  }

  // Fungsi untuk menghitung total harga barang
  void _calculateTotal() {
    setState(() {
      totalHarga = _items.fold(0, (sum, item) {
        int harga = int.tryParse(item['harga_barang']!.text) ?? 0;
        return sum + harga;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _items[index]['nama_barang'],
                            decoration: InputDecoration(
                              labelText: 'Nama Barang',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: _items[index]['harga_barang'],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Harga Barang',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _calculateTotal(); // Menghitung total harga setiap kali harga barang berubah
                            },
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Tambah Barang'),
            ),
            SizedBox(height: 16),
            // Menampilkan Total Harga
            Text(
              'Total Harga: Rp$totalHarga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Obx(() {
              return ElevatedButton(
                onPressed: dataController.isLoading.value
                    ? null
                    : () async {
                        // Mengonversi data inputan menjadi list Barang
                        List<Barang> barangList = _items.map((item) {
                          return Barang(
                            namaBarang: item['nama_barang']!.text,
                            hargaBarang:
                                int.tryParse(item['harga_barang']!.text) ?? 0,
                          );
                        }).toList();

                        // Menambahkan barang menggunakan controller
                        bool success = await dataController.tambahBarang(barangList);

                        if (success) {
                          // Navigasi ke halaman HomeView
                          Get.offAllNamed('/home');
                        } else {
                          // Tampilkan pesan error jika gagal
                          Get.snackbar(
                            'Gagal Menyimpan',
                            'Terjadi kesalahan saat menyimpan data.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                child: dataController.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Simpan Barang'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
