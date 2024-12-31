import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/alamat_tagihan/views/alamat_tagihan_view.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';

class KeranjangView extends StatefulWidget {
  const KeranjangView({super.key});

  @override
  _KeranjangViewState createState() => _KeranjangViewState();
}

class _KeranjangViewState extends State<KeranjangView> {
  final List<String> selectedItems = []; // To track selected items for checkout
  final AuthController authController = Get.find<AuthController>();
  bool isAllSelected = false;

  // Helper function to load image based on `image_url`
  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      // Use local asset if the path starts with "assets/"
      return Image.asset(
        imagePath,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    } else {
      // Use network image otherwise
      return Image.network(
        imagePath,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    }
  }

  // Function to toggle the selection of the item
  void toggleSelection(String productId) {
    setState(() {
      if (selectedItems.contains(productId)) {
        selectedItems.remove(productId); // Unselect item
        isAllSelected = false;
      } else {
        selectedItems.add(productId); // Select item
      }
    });
  }

  // Function to toggle selection of all items
  void toggleSelectAll(List<QueryDocumentSnapshot> cartItems) {
    setState(() {
      if (isAllSelected) {
        selectedItems.clear();
        isAllSelected = false;
      } else {
        selectedItems.clear();
        selectedItems.addAll(cartItems.map((item) => item.id));
        isAllSelected = true;
      }
    });
  }

  // Helper functions to parse price and quantity safely
  double parsePrice(String price) {
    return double.tryParse(price) ?? 0.0; // Return 0.0 if parsing fails
  }

  int parseQuantity(String quantity) {
    return int.tryParse(quantity) ?? 1; // Return 1 if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Get the current logged-in user

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Keranjang"),
        ),
        body: const Center(
          child: Text("Silakan login untuk melihat keranjang Anda."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8B4513),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .where('uid', isEqualTo: user.uid) // Fetch only the user's cart items
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Keranjang Anda kosong."));
          }

          final cartItems = snapshot.data!.docs;

          // Calculate the total price based on selected items
          double totalPrice = cartItems.fold(
            0,
            (sum, item) {
              final data = item.data() as Map<String, dynamic>;

              // Safely parse price and quantity
              final priceString = data['price']?.toString() ?? '0'; // Fallback to '0' if null
              final quantityString = data['quantity']?.toString() ?? '1'; // Fallback to '1' if null

              final price = parsePrice(priceString);
              final quantity = parseQuantity(quantityString);

              if (selectedItems.contains(item.id)) {
                return sum + (price * quantity);
              }
              return sum;
            },
          );

          return Column(
            children: [
              // Select All Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isAllSelected,
                      onChanged: (_) => toggleSelectAll(cartItems),
                      activeColor: const Color(0xFF8B4513),
                    ),
                    const Text('Pilih Semua'),
                  ],
                ),
              ),

              // Cart Items List
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index].data() as Map<String, dynamic>;
                    final name = item['name'] ?? 'No Name';
                    final price = item['price'] ?? '0';
                    final imageUrl = item['imageUrl'] ?? 'assets/default_image.png';
                    final size = item['size'] ?? 'Unknown';
                    final quantity = item['quantity'] ?? 1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: _keranjangItem(
                        cartItems[index].id, // Pass product id for deletion
                        name,
                        price,
                        imageUrl,
                        size,
                        quantity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              _totalSection(context, totalPrice.toStringAsFixed(2), cartItems),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        backgroundColor: const Color(0xFF8B4513),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white,
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

  Widget _keranjangItem(
    String productId,
    String title,
    String price,
    String imageUrl,
    String size,
    int quantity,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8B4513)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: selectedItems.contains(productId),
              onChanged: (_) => toggleSelection(productId),
              activeColor: const Color(0xFF8B4513),
            ),
            loadImage(imageUrl),
          ],
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga: Rp. $price', style: const TextStyle(color: Color(0xFF8B4513))),
            Text('Ukuran: $size'),
            Text('x$quantity'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Use the controller method instead of the local method
            authController.deleteCartItem(productId);
          },
        ),
      ),
    );
  }

  Widget _totalSection(BuildContext context, String totalPrice, List<QueryDocumentSnapshot> cartItems) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Harga',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Rp. $totalPrice',
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
              if (selectedItems.isNotEmpty) {
                Get.to(() => AlamatTagihanView(selectedItemIds: selectedItems));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pilih setidaknya satu produk'))
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}