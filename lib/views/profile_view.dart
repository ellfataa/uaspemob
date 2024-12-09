import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => Text('Email: ${profileController.email.value}')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}