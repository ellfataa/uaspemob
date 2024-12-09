import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register_model.dart';

class RegisterController {
  final String apiUrl = "http://192.168.18.7/uas/register.php";

  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {
          "status": "error",
          "message":
              "Gagal melakukan registrasi. Server tidak merespon dengan benar."
        };
      }
    } catch (e) {
      return {"status": "error", "message": "Terjadi kesalahan: $e"};
    }
  }
}
