import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/home_model.dart';

class HomeController extends GetxController {
  var barangList = <Barang>[].obs; // Daftar barang
  var isLoading = false.obs; // Indikator loading

  final String apiUrl = 'http://192.168.18.7/uas/lihat.php'; // API URL

  // Fetch barang dari server
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
}
