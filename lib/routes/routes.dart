import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';
import '../views/data_view.dart';
import '../views/landing_view.dart';
import '../views/register_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => LandingView()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(
        name: '/register',
        page: () => RegisterView()), // Tambahkan halaman register
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/profile', page: () => ProfileView()),
    GetPage(name: '/data', page: () => DataView()),// Menambahkan halaman transaksi
  ];
}
