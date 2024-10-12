import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

// Halaman utama dengan tampilan seperti pada gambar
class ProfileView extends StatelessWidget {
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
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text('U & I', style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          ListTile(
            title: Text('Pesanan Saya'),
            //onTap: () => Get.to(OrderPage()), // Navigasi ke halaman Pesanan
          ),
          Divider(),
          ListTile(
            title: Text('Voucher'),
            //onTap: () => Get.to(VoucherPage()), // Navigasi ke halaman Voucher
          ),
          Divider(),
          ListTile(
            title: Text('Alamat Saya'),
            trailing: Icon(Icons.arrow_forward_ios),
            //onTap: () => Get.to(AddressPage()), // Navigasi ke halaman Alamat
          ),
          Divider(),
          ListTile(
            title: Text('FAQ'),
            trailing: Icon(Icons.arrow_forward_ios),
            //onTap: () => Get.to(FaqPage()), // Navigasi ke halaman FAQ
          ),
          Divider(),
          ListTile(
            title: Text('Pengaturan'),
            trailing: Icon(Icons.arrow_forward_ios),
            //onTap: () => Get.to(SettingsPage()), // Navigasi ke halaman Pengaturan
          ),
        ],
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
}