import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/data_model.dart';

class DataController extends GetxController {
  var isLoading = false.obs;

  final String apiUrl =
      "http://192.168.18.7/uas/tambah.php";

  Future<bool> tambahBarang(List<Barang> barangList) async {
    isLoading.value = true;

    try {
      List<Map<String, dynamic>> dataBarang = barangList.map((barang) {
        return barang.toJson();
      }).toList();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'barang': dataBarang}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Jika barang berhasil ditambahkan
          Get.snackbar('Success', responseData['message']);
          return true;
        } else {
          // Menampilkan pesan kesalahan
          Get.snackbar('Error', responseData['message']);
          return false;
        }
      } else {
        // Jika server merespons dengan status selain 200
        Get.snackbar('Error', 'Terjadi kesalahan saat menghubungi server.');
        return false;
      }
    } catch (e) {
      // Menangani kesalahan jaringan atau lainnya
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      return false;
    } finally {
      isLoading.value = false; // Menandakan bahwa proses telah selesai
    }
  }
}
