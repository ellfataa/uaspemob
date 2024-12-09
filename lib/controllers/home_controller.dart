import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/home_model.dart';

class HomeController extends GetxController {
  var barangList = <Barang>[].obs;
  var isLoading = false.obs;

  final String apiUrl = 'http://192.168.18.7/uas/lihat.php';
  final String deleteUrl = 'http://192.168.18.7/uas/hapus.php';

  Future<void> fetchBarang() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          barangList.value = (data['data'] as List)
              .map((item) => Barang.fromJson(item))
              .toList();
        } else {
          print("Error: ${data['message']}");
        }
      } else {
        print("Failed to fetch data");
      }
    } catch (e) {
      print("Error fetching barang: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Menghapus barang berdasarkan ID
  Future<void> deleteBarang(int idBarang) async {
    try {
      final response = await http.get(Uri.parse('$deleteUrl?id_barang=$idBarang'));
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        barangList.removeWhere((barang) => barang.idBarang == idBarang);
        Get.snackbar('Berhasil', data['message'], snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Gagal', data['message'], snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error deleting barang: $e");
      Get.snackbar('Error', 'Gagal menghapus barang', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
