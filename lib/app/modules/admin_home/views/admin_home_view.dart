import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/admin_faq/views/admin_faq_view.dart';
import 'package:myapp/app/modules/admin_produk/views/admin_produk_view.dart';

class AdminHomeView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>(); // Mendapatkan instance AuthController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Admin'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Tambah Produk'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(AdminProdukView());
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Tambah FAQ'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(AdminFaqView());
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context); // Menampilkan dialog konfirmasi logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8B4513), // Warna coklat
                foregroundColor: Colors.white, // Warna teks dan ikon putih
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.white), // Warna ikon putih
                  SizedBox(width: 8),
                  Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)), // Warna teks putih
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Menampilkan dialog konfirmasi untuk logout
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa logout
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                authController.logout(); // Memanggil metode logout
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)), // Teks tombol Logout berwarna merah
            ),
          ],
        );
      },
    );
  }
}
