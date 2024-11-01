import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart'; // Import AuthController
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/user_profil/views/user_profil_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Menginisialisasi AuthController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Akun Saya',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.brown,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white, size: 15),
                      onPressed: () {
                        Get.to(UserProfilView());
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('U & I', style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ListTile(
              title: Text('Pesanan Saya'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman Pesanan
                // Get.to(() => OrderPage());
              },
            ),
            Divider(),
            ListTile(
              title: Text('Alamat Saya'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman Alamat
                // Get.to(() => AddressPage());
              },
            ),
            Divider(),
            ListTile(
              title: Text('FAQ'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman FAQ
                // Get.to(() => FaqPage());
              },
            ),
            Divider(),
            ListTile(
              title: Text('Pengaturan'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman Pengaturan
                // Get.to(() => SettingsPage());
              },
            ),
            Divider(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B4513), // Warna coklat
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, 50), // Lebar penuh
                ),
                onPressed: () {
                  // Menampilkan dialog konfirmasi logout
                  _showLogoutDialog(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        backgroundColor: Color(0xFF8B4513), // Warna coklat
        selectedItemColor: Colors.black54, // Warna item yang dipilih
        unselectedItemColor: Colors.white, // Warna item yang tidak dipilih
        onTap: (index) {
          // Handle navigation on tap
          switch (index) {
            case 0:
              Get.to(AllbrandView());
              break;
            case 1:
              Get.to(PencarianView());
              break;
            case 2:
              Get.to(KeranjangView());
              break;
            case 3:
              Get.to(WishlistView());
              break;
            case 4:
              Get.to(ProfileView());
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout dari akun?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Oke'),
              onPressed: () {
                authController.logout(); // Memanggil fungsi logout
              },
            ),
          ],
        );
      },
    );
  }
}
