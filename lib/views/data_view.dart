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
  int totalHarga = 0;

  @override
  void initState() {
    super.initState();
    _addItem();
  }

  void _addItem() {
    setState(() {
      _items.add({
        'nama_barang': TextEditingController(),
        'harga_barang': TextEditingController(),
      });
    });
  }

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
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Kasir',
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _items[index]['nama_barang'],
                            decoration: InputDecoration(
                              labelText: 'Nama Barang',
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              prefixIcon: Icon(Icons.shopping_cart,
                                  color: Colors.green),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _items[index]['harga_barang'],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Harga Barang',
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              prefixIcon:
                                  Icon(Icons.attach_money, color: Colors.green),
                            ),
                            onChanged: (value) {
                              _calculateTotal();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.green.shade50,
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    Text(
                      'Rp$totalHarga',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Tambah Barang',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: dataController.isLoading.value
                        ? null
                        : () async {
                            List<Barang> barangList = _items.map((item) {
                              return Barang(
                                namaBarang: item['nama_barang']!.text,
                                hargaBarang:
                                    int.tryParse(item['harga_barang']!.text) ??
                                        0,
                              );
                            }).toList();

                            bool success =
                                await dataController.tambahBarang(barangList);

                            if (success) {
                              Get.offAllNamed('/home');
                            } else {
                              Get.snackbar(
                                'Gagal Menyimpan',
                                'Terjadi kesalahan saat menyimpan data.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: dataController.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Selesaikan Transaksi',
                            style: TextStyle(color: Colors.white),
                          ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
