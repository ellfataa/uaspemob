import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

class LoginController extends GetxController {
  var isLogged = false.obs;
  var user = Rxn<User>();
  var isLoading = false.obs;

  final String apiUrl = "http://192.168.18.7/uas/login.php";

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username dan password harus diisi');
      return;
    }

    isLoading.value = true;
    try {
      // Kirim permintaan ke API
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Jika login berhasil, set user dan alihkan ke halaman utama
          user.value = User.fromJson(responseData['data']);
          isLogged.value = true;
          Get.offAllNamed('/home');
        } else {
          // Tampilkan pesan error dari server
          Get.snackbar('Error', responseData['message']);
        }
      } else {
        Get.snackbar('Error', 'Terjadi kesalahan saat menghubungi server.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
