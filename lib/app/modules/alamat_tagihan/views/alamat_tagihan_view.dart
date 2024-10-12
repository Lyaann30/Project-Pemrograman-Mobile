import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pembayaran/views/pembayaran_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';
import '../controllers/alamat_tagihan_controller.dart';

class AlamatTagihanView extends GetView<AlamatTagihanController> {
  const AlamatTagihanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Untuk navigasi kembali
          },
        ),
      ),
      body: SingleChildScrollView(
        // Menambahkan fungsi scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper progress indicator (optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.circle,
                    size: index == 0
                        ? 12
                        : 8, // Icon bulat, yang pertama lebih besar
                    color: index == 0 ? Color(0xFF8B4513) : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Billing address header
            const Text(
              'Billing address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Full name input
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Halid Baladraf',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Address input
            const TextField(
              decoration: InputDecoration(
                labelText: 'Alamat',
                hintText:
                    'Jl. Raya Dermo, Jetak Lor, Mulyoagung, Kec. Dau, Kabupaten Malang.',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Province and Postal Code input (side by side)
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Provinsi',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Jawa Timur',
                        child: Text('Jawa Timur'),
                      ),
                      // Tambahkan item dropdown lainnya sesuai kebutuhan
                    ],
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Pos Kode',
                      hintText: '65151',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Country input
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Negara',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Indonesia',
                  child: Text('Indonesia'),
                ),
                // Tambahkan item dropdown lainnya sesuai kebutuhan
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Shipping Option input
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Opsi Pengiriman',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Pengiriman Standar ( + Rp. 12.000 )',
                  child: Text('Pengiriman Standar ( + Rp. 12.000 )'),
                ),
                // Tambahkan item dropdown lainnya sesuai kebutuhan
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Save billing details checkbox
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                const Text('Simpan detail untuk alamat penagihan'),
              ],
            ),

            const SizedBox(height: 16),

            // Proceed to payment button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(PembayaranView());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  backgroundColor: Color(0xFF8B4513), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Lanjutkan ke Pembayaran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: const Color(0xFF8B4513), // Warna coklat
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
              Get.to(KeranjangView()); // Sesuaikan dengan navigasi Cart
              break;
            case 3:
              Get.to(WishlistView()); // Sesuaikan dengan navigasi Wishlist
              break;
            case 4:
              Get.to(ProfileView());
              break;
          }
        },
        items: const [
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
}
