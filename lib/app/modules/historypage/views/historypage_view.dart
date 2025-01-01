import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';
import 'package:myapp/app/modules/profilepage/views/profilepage_view.dart'; // Pastikan ini adalah path yang benar untuk HomePage

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.to(() =>
                const HomePage()); // Navigasi ke HomePage saat tombol back ditekan
          },
        ),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.info_outline, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Utama',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Mengatur indeks aktif ke tombol tengah
        onTap: (index) {
          if (index == 0) {
            // Navigasi ke HomePage saat tombol Home diklik
            Get.to(() => const HomePage());
          } else if (index == 1) {
            // Tetap di halaman History saat tombol History diklik
            Get.to(() => const HistoryPage());
          } else if (index == 2) {
            // Tambahkan navigasi ke halaman profil jika diperlukan
            Get.to(() => ProfilePage());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
