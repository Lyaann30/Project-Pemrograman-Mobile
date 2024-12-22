import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/brandfm1/views/brandfm1_view.dart';
import 'package:myapp/app/modules/brandfm2/views/brandfm2_view.dart';
import 'package:myapp/app/modules/brandhm1/views/brandhm1_view.dart';
import 'package:myapp/app/modules/brandhm2/views/brandhm2_view.dart';
import 'package:myapp/app/modules/brandms1/views/brandms1_view.dart';
import 'package:myapp/app/modules/brandms2/views/brandms2_view.dart';
import 'package:myapp/app/modules/brandvindys1/views/brandvindys1_view.dart';
import 'package:myapp/app/modules/brandvindys2/views/brandvindys2_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class PencarianView extends StatefulWidget {
  const PencarianView({Key? key}) : super(key: key);

  @override
  _PencarianViewState createState() => _PencarianViewState();
}

class _PencarianViewState extends State<PencarianView> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Masukkan barang yang ingin dicari',
                hintStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fillColor: const Color(0xFF8B4513), // Warna coklat
                filled: true,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Hasil Pencarian',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchText.isEmpty
                ? Center(child: Text('Silakan masukkan kata kunci untuk mencari produk.'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('name', isGreaterThanOrEqualTo: _searchText)
                        .where('name', isLessThanOrEqualTo: '$_searchText\uf8ff')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Produk tidak ditemukan.'));
                      }
                      final products = snapshot.data!.docs;
                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final productData = products[index].data() as Map<String, dynamic>;
                          return _buildProductItem(
                            productData['name'] ?? 'No Name',
                            'Rp. ${productData['price']?.toStringAsFixed(3) ?? '0.0'}',
                            productData['image_url'] ?? 'assets/placeholder.png', 
                            productData['size']?.toString() ?? 'N/A', // Ukuran
                            productData['stock']?.toString() ?? 'N/A', // Stok
                            () {
                              if (productData['name'] == 'ForMen AF 101 Sepatu Loafers Kulit') {
                                Get.to(Brandfm1View());
                              } else if (productData['name'] == 'ForMen AF 104 Sepatu Loafers Kulit') {
                                Get.to(Brandfm2View());
                              } else if (productData['name'] == 'Handymen 204 Sepatu Formal Kulit') {
                                Get.to(Brandhm1View());
                              } else if (productData['name'] == 'Handymen 971 Sepatu Safety Pendek') {
                                Get.to(Brandhm2View());
                              } else if (productData['name'] == 'Mr. Show 501 Sepatu Formal Kulit') {
                                Get.to(Brandms1View());
                              } else if (productData['name'] == 'Mr. Show 502 Sepatu Formal Kulit') {
                                Get.to(Brandms2View());
                              } else if (productData['name'] == 'Vindys 502 Mid Heels Formal Shoes') {
                                Get.to(Brandvindys1View());
                              } else if (productData['name'] == 'Vindys 503 Mid Heels Formal Shoes') {
                                Get.to(Brandvindys2View());
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1, // Mengatur indeks pada Search
        backgroundColor: const Color(0xFF8B4513), // Warna coklat
        selectedItemColor: Colors.black54, // Warna item yang dipilih
        unselectedItemColor: Colors.white, // Warna item yang tidak dipilih
        onTap: (index) {
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

  Widget _buildProductItem(String title, String price,
      String image, String size, String stock, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Colors.brown)),
            const SizedBox(height: 4),
            Text('Ukuran: $size', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text('Stok: $stock', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
