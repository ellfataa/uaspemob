import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.green.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                'Sidebar Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.add_box,
                  text: 'Kasir',
                  onTap: () {
                    Get.toNamed('/data');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    // logout
                    Get.offAllNamed('/login');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'v1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 24),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
