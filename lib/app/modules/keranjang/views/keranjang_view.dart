import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/alamat_tagihan/views/alamat_tagihan_view.dart';
import '../controllers/keranjang_controller.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart'; // Import AllbrandView
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart'; // Import PencarianView
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart'; // Import WishlistView
import 'package:myapp/app/modules/profile/views/profile_view.dart'; // Import ProfileView

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.white, // Mengubah warna teks menjadi putih
          ),
        ),
        backgroundColor: Color(0xFF8B4513),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Ikon back juga berwarna putih
          onPressed: () {
            Get.back(); // Untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _keranjangItem(
                    'Mr.Show 502 Sepatu Formal Kulit',
                    'Rp 384.400',
                    'assets/Mr.Show 502 Sepatu Formal Kulit.png', // Gambar dari asset
                  ),
                  const SizedBox(height: 16),
                  _keranjangItem(
                    'Vindys 503 Mid Heels Formal Shoes',
                    'Rp 209.900',
                    'assets/Vindys Lawender 503 Mid Heels Formal Shoes.png', // Gambar dari asset
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _promoSection(),
            const SizedBox(height: 16),
            _totalSection(context, 'Rp 594.300'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Set index untuk halaman ini (Cart)
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

  Widget _keranjangItem(String title, String price, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF8B4513)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Checkbox(
            value: true, // Logika ceklis bisa disesuaikan
            onChanged: (value) {},
            activeColor: Color(0xFF8B4513),
          ),
          Image.asset(
            imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF8B4513),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoSection() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Kode Promo',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              const Text(
                'NV24Q3U',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  // Logika untuk menghapus kode promo
                },
                child: const Icon(Icons.close, size: 18, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalSection(BuildContext context, String totalPrice) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '2 barang',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              totalPrice,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Get.to(AlamatTagihanView());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8B4513),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Mengubah warna teks menjadi putih
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
