import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Laptop',
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
