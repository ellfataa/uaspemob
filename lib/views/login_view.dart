import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Obx(() {
              return ElevatedButton(
                onPressed: loginController.isLoading.value
                    ? null // Nonaktifkan tombol saat loading
                    : () {
                        loginController.login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                child: loginController.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Login'),
              );
            }),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Get.toNamed('/register'); // Navigasi ke halaman register
              },
              child: Text(
                "Belum punya akun? Daftar di sini",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (loginController.isLogged.value) {
                return Text(
                  'Login Berhasil!',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                );
              }
              return SizedBox
                  .shrink(); // Tidak menampilkan apa pun jika belum login
            }),
          ],
        ),
      ),
    );
  }
}
