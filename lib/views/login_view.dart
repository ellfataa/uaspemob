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
        title: Text('Login', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.toNamed(
                '/landing');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Inputan username
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.green),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Inputan password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Tombol Login
            Obx(() {
              return ElevatedButton(
                onPressed: loginController.isLoading.value
                    ? null
                    : () {
                        loginController.login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: loginController.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Login',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              );
            }),
            SizedBox(height: 16),

            // Link ke Halaman Register
            GestureDetector(
              onTap: () {
                Get.toNamed('/register');
              },
              child: Text(
                "Belum punya akun? Daftar di sini",
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Pesan Login Berhasil
            Obx(() {
              if (loginController.isLogged.value) {
                return Text(
                  'Login Berhasil!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              }
              return SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
