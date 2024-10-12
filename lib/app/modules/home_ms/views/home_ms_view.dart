import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/brandfm1/views/brandfm1_view.dart';
import 'package:myapp/app/modules/brandhm1/views/brandhm1_view.dart';
import 'package:myapp/app/modules/brandms1/views/brandms1_view.dart';
import 'package:myapp/app/modules/brandms2/views/brandms2_view.dart';
import 'package:myapp/app/modules/brandvindys1/views/brandvindys1_view.dart';
import 'package:myapp/app/modules/home_fm/views/home_fm_view.dart';
import 'package:myapp/app/modules/home_hm/views/home_hm_view.dart';
import 'package:myapp/app/modules/home_vd/views/home_vd_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class HomeMsView extends StatelessWidget {
  // List Produk
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/Mr.Show 501 Sepatu Formal Kulit.png',
      'name': 'Mr.Show 501 Sepatu Formal Kulit',
      'price': 'Rp. 384.400',
      'rating': 5.0
    },
    {
      'image': 'assets/Mr.Show 502 Sepatu Formal Kulit.png',
      'name': 'Mr.Show 502 Sepatu Formal Kulit',
      'price': 'Rp. 394.400',
      'rating': 5.0
    },
    {
      'image': 'assets/Mr.Show PD02 Sepatu Kasual Kulit.png',
      'name': 'Mr.Show PD02 Sepatu Kasual Kulit',
      'price': 'Rp. 342.800',
      'rating': 5.0
    },
    {
      'image': 'assets/Mr.Show SBT07 Sepatu Casual Mid Boot.png',
      'name': 'Mr.Show SBT07 Sepatu Casual Mid Boot',
      'price': 'Rp. 478.000',
      'rating': 5.0
    },
  ];

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0), // Menambahkan padding di sebelah kanan
            child: GestureDetector(
              child: Icon(
                Icons.account_circle,
                color: Colors.purple,
                size: 40, // Ukuran ikon lebih besar
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildBanner(
                        'New Brand Men Style ForMen',
                        'assets/ForMen AF 101 Sepatu Loafers Kulit.png',
                        'Beli Sekarang'),
                    SizedBox(width: 20),
                    buildBanner(
                        'New Brand Women Style Mr.Show',
                        'assets/Mr.Show 501 Sepatu Formal Kulit.png',
                        'Beli Sekarang'),
                    SizedBox(width: 20),
                    buildBanner(
                        'New Brand Men Style HandyMen',
                        'assets/Handymen 204 Sepatu Formal Kulit.png',
                        'Beli Sekarang'),
                    SizedBox(width: 20),
                    buildBanner(
                        'New Brand Women Style Vindys',
                        'assets/Vindys Lawender 502 Mid Heels Formal Shoes.png',
                        'Beli Sekarang'),
                  ],
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
                  'Brand Mr.Show',
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
                  brandLogo('Mr.Show', 'assets/Logo Brand Ms.png',
                      logoSize: 20),
                  brandLogo('Vindys', 'assets/Logo Brand Vs.png', logoSize: 20),
                ],
              ),
            ),

            // Product Grid Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
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
                  return productCard(
                    products[index]['image'],
                    products[index]['name'],
                    products[index]['price'],
                    products[index]['rating'],
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

  // Helper to build product card with dynamic data
  Widget productCard(
      String imagePath, String name, String price, double rating) {
    return GestureDetector(
      onTap: () {
        // Navigate to product detail page
        if (name == 'Mr.Show 501 Sepatu Formal Kulit ') {
          Get.to(Brandms1View());
        } else if (name == 'Mr.Show 502 Sepatu Formal Kulit') {
          Get.to(Brandms2View());
        } 
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(imagePath, height: 100, width: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(price),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build brand banner
  Widget buildBanner(String title, String imagePath, String buttonText) {
    return Expanded(
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF8B4513),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 80, width: 80),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the corresponding product detail page
                    if (title.contains('ForMen')) {
                      Get.to(Brandfm1View());
                    } else if (title.contains('Mr.Show')) {
                      Get.to(Brandms1View());
                    } else if (title.contains('HandyMen')) {
                      Get.to(Brandhm1View());
                    } else if (title.contains('Vindys')) {
                      Get.to(Brandvindys1View());
                    }
                  },
                  child: Text(buttonText),
                ),
              ],
            ),
          ],
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
