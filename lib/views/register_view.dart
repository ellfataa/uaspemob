import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../models/register_model.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterController _controller = RegisterController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("Semua field harus diisi.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final user = User(username: username, email: email, password: password);
    final result = await _controller.registerUser(user);

    setState(() {
      _isLoading = false;
    });

    final message = result['message'] ?? "Terjadi kesalahan.";
    _showSnackBar(message);

    if (result['status'] == "success") {
      // Arahkan ke halaman login jika registrasi berhasil
      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed('/login');
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Inputan username
              TextField(
                controller: _usernameController,
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

              // Inputan email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Inputan password
              TextField(
                controller: _passwordController,
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

              // Tombol Register
              Center(
                child: SizedBox(
                  width: 200, 
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Register',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Link ke Halaman Login
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    "Sudah punya akun? Login di sini",
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
