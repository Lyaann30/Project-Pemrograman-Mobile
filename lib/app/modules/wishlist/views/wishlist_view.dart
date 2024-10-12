import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/alamat_tagihan/views/alamat_tagihan_view.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF8B4513), // Warna header
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          wishlistItem(
            imageUrl: 'assets/Vindys Lawender 502 Mid Heels Formal Shoes.png', // Ganti dengan gambar asli
            name: 'Vindys 502 Mid Heels Formal Shoes',
            price: 'Rp. 209.900',
          ),
          wishlistItem(
            imageUrl: 'assets/ForMen AF 104 Sepatu Loafers Kulit.png', // Ganti dengan gambar asli
            name: 'ForMen AF 104 Sepatu Loafers Kulit',
            price: 'Rp. 302.175',
          ),
          wishlistItem(
            imageUrl: 'assets/ForMen AF 101 Sepatu Loafers Kulit.png', // Ganti dengan gambar asli
            name: 'ForMen AF 101 Sepatu Loafers Kulit',
            price: 'Rp. 302.175',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // Karena ini halaman Wishlist, index 3 diaktifkan
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
              Get.to(KeranjangView()); // Navigasi ke halaman Cart
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

  Widget wishlistItem({
    required String imageUrl,
    required String name,
    required String price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Image.asset(
          imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Get.to(AlamatTagihanView());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513), // Warna tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Beli Sekarang',
            style: TextStyle(
              color: Colors.white, // Ubah warna teks menjadi putih
            ),
          ),
        ),
      ),
    );
  }
}
