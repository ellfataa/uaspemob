import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/sidebar_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.fetchBarang();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: SidebarWidget(),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (homeController.barangList.isEmpty) {
          return Center(child: Text('Tidak ada data barang.'));
        }

        int totalHarga = homeController.barangList.fold(
          0,
          (sum, barang) => sum + barang.hargaBarang,
        );
        int totalTransaksi = homeController.barangList.length;

        // Data untuk grafik pie
        double transaksiValue = totalTransaksi.toDouble();
        double penjualanValue = totalHarga.toDouble();

        double total = transaksiValue + penjualanValue;

        List<PieChartSectionData> pieSections = [
          PieChartSectionData(
            color: const Color.fromARGB(255, 255, 58, 67),
            value: (transaksiValue / total) * 100,
            title: 'Transaksi\n$totalTransaksi',
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          PieChartSectionData(
            color: const Color.fromARGB(255, 64, 176, 246),
            value: (penjualanValue / total) * 100,
            title: 'Penjualan\nRp$totalHarga',
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ];

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: homeController.barangList.length,
                itemBuilder: (context, index) {
                  final barang = homeController.barangList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        barang.namaBarang,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Harga: Rp${barang.hargaBarang}'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: Icon(Icons.shopping_cart),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          homeController.deleteBarang(barang.idBarang);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Total Transaksi: $totalTransaksi',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Total Harga: Rp$totalHarga',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Grafik Pie
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(8),
                    child: PieChart(
                      PieChartData(
                        sections: pieSections,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 3,
                        centerSpaceRadius: 30,
                        startDegreeOffset: 180,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/data');
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          tooltip: 'Tambah Barang',
        ),
      ),
    );
  }
}
