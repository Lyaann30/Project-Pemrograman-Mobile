import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/brandfm1/views/brandfm1_view.dart';
import 'package:myapp/app/modules/brandfm2/views/brandfm2_view.dart';
import 'package:myapp/app/modules/brandhm1/views/brandhm1_view.dart';
import 'package:myapp/app/modules/brandhm2/views/brandhm2_view.dart';
import 'package:myapp/app/modules/brandms1/views/brandms1_view.dart';
import 'package:myapp/app/modules/brandms2/views/brandms2_view.dart';
import 'package:myapp/app/modules/brandvindys1/views/brandvindys1_view.dart';
import 'package:myapp/app/modules/brandvindys2/views/brandvindys2_view.dart';
import 'package:myapp/app/modules/home_fm/views/home_fm_view.dart';
import 'package:myapp/app/modules/home_hm/views/home_hm_view.dart';
import 'package:myapp/app/modules/home_ms/views/home_ms_view.dart';
import 'package:myapp/app/modules/home_vd/views/home_vd_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class AllbrandView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/Logo.png', height: 60),
            SizedBox(width: 0),
            Text(
              'rajasepatukulit',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    // Definisikan bannerData di luar itemBuilder
                    final List<Map<String, dynamic>> bannerData = [
                      {
                        'title': 'New Brand Men Style ForMen',
                        'image': 'assets/ForMen AF 101 Sepatu Loafers Kulit.png',
                        'route': Brandfm1View(),
                      },
                      {
                        'title': 'New Brand Women Style Mr.Show',
                        'image': 'assets/Mr.Show 501 Sepatu Formal Kulit.png',
                        'route': Brandms1View(),
                      },
                      {
                        'title': 'New Brand Men Style HandyMen',
                        'image': 'assets/Handymen 204 Sepatu Formal Kulit.png',
                        'route': Brandhm1View(),
                      },
                      {
                        'title': 'New Brand Women Style Vindys',
                        'image': 'assets/Vindys Lawender 502 Mid Heels Formal Shoes.png',
                        'route': Brandvindys1View(),
                      },
                    ];

                    // Akses data dengan type casting yang tepat
                    return Container(
                      width: 300,
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF8B4513),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            bannerData[index]['image'] as String, // Tambahkan type casting
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bannerData[index]['title'] as String, // Tambahkan type casting
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(bannerData[index]['route'] as Widget); // Tambahkan type casting jika diperlukan
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Color(0xFF8B4513), backgroundColor: Colors.white,
                                  ),
                                  child: Text('Beli Sekarang'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Teks "All Brands" di sebelah kiri
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'All Brands',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Brand Logos Section
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  brandLogo('All', 'assets/Logo All Brand.png', logoSize: 20),
                  brandLogo('Hm', 'assets/Logo Brand Hm.png', logoSize: 20),
                  brandLogo('Fm', 'assets/Logo Brand Fm.png', logoSize: 20),
                  brandLogo('Mr.Show', 'assets/Logo Brand Ms.png',logoSize: 20),
                  brandLogo('Vindys', 'assets/Logo Brand Vs.png', logoSize: 20),
                ],
              ),
            ),

            // Product Grid Section using Firebase Firestore
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('products').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No products available.'));
                  }

                  final products = snapshot.data!.docs;
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final productData = products[index].data() as Map<String, dynamic>;
                      final imagePath = productData['image_url'] ?? 'assets/placeholder.png';
                      
                      return productCard(
                        imagePath,
                        productData['name'] ?? 'No Name',
                        productData['price']?.toDouble() ?? 0.0,
                        productData['size'] ?? 'N/A',
                        productData['stock'] ?? 0,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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

  // Mengambil data dari Firebase dan menampilkan card produk dengan data yang diminta
  Widget productCard(String imagePath, String name, double price, String size, int stock) {
  return GestureDetector(
    onTap: () {
      // Arahkan ke halaman detail produk (dengan kondisi lebih spesifik)
      if (name == 'Mr. Show 501 Sepatu Formal Kulit') {
        Get.to(Brandms1View());
      } else if (name == 'Mr. Show 502 Sepatu Formal Kulit') {
        Get.to(Brandms2View());
      } else if (name == 'ForMen AF 101 Sepatu Loafers Kulit') {
        Get.to(Brandfm1View());
      } else if (name == 'ForMen AF 104 Sepatu Loafers Kulit') {
        Get.to(Brandfm2View());
      } else if (name == 'Handymen 204 Sepatu Formal Kulit') {
        Get.to(Brandhm1View());
      } else if (name == 'Handymen 971 Sepatu Safety Pendek') {
        Get.to(Brandhm2View());
      } else if (name == 'Vindys 502 Mid Heels Formal Shoes') {
        Get.to(Brandvindys1View());
      } else if (name == 'Vindys 503 Mid Heels Formal Shoes') {
        Get.to(Brandvindys2View());
      }
    },
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                imagePath, // Menggunakan Image.asset karena path lokal
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Rp. ${price.toStringAsFixed(3)}',
              style: TextStyle(fontSize: 14, color: Colors.brown),
            ),
            Text(
              'Ukuran: $size',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Stok: $stock',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget brandLogo(String brandName, String imagePath, {double logoSize = 30}) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding brand page
        if (brandName == 'Fm') {
          Get.to(HomeFmView());
        } else if (brandName == 'Hm') {
          Get.to(HomeHmView());
        } else if (brandName == 'Vindys') {
          Get.to(HomeVdView());
        } else if (brandName == 'Mr.Show') {
          Get.to(HomeMsView());
        } else if (brandName == 'All') {
          Get.to(AllbrandView());
        }
      },
      child: Center(  // Centering the entire brand logo widget
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,  // Center the logo inside the container
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular shape
              border: Border.all(
                  color: Color(0xFF8B4513), width: 2), // Thinner border
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: logoSize * 1.0, // Ensure logo size
            ),
          ),
        ),
      ),
    );
  }
}
