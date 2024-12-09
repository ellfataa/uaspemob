import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.fetchBarang(); // Fetch barang saat halaman dimuat

    return Scaffold(
      appBar: AppBar(
        title: Text('Home - Daftar Barang'),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (homeController.barangList.isEmpty) {
          return Center(child: Text('Tidak ada data barang.'));
        }

        return ListView.builder(
          itemCount: homeController.barangList.length,
          itemBuilder: (context, index) {
            final barang = homeController.barangList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(barang.namaBarang),
                subtitle: Text('Harga: Rp${barang.hargaBarang}'),
                leading: CircleAvatar(
                  child: Text('${barang.idBarang}'),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/data'); // Navigasi ke DataView
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Barang',
      ),
    );
  }
}
