import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';

class KeranjangHm1View extends StatefulWidget {
  const KeranjangHm1View({super.key});

  @override
  _KeranjangHM1ViewState createState() => _KeranjangHM1ViewState();
}

class _KeranjangHM1ViewState extends State<KeranjangHm1View> {
  int quantity = 1;

  // Increment and decrement quantity functions
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  // Load product data from Firebase
  Future<DocumentSnapshot> getProductData() async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc('E6tNEo4VeQxrWlJZVFnp') // Replace with the actual product ID
        .get();
  }

  // Helper function to load image based on `image_url`
  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      // Use local asset if the path starts with "assets/"
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    } else {
      // Use network image otherwise
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Keranjang Produk'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getProductData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Produk tidak ditemukan.'));
          }

          var productData = snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> additionalImages =
              productData['additional_images'] ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                // Display the main product image using the helper function
                Container(
                  height: 180,
                  width: double.infinity,
                  child: loadImage(productData['image_url'] ?? ''),
                ),
                const SizedBox(height: 10),

                // Additional images with custom layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < additionalImages.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Transform.translate(
                              offset: Offset(-90.0 * i,
                                  0), // Horizontal offset for overlapping effect
                              child: Container(
                                height: 150,
                                width: 150,
                                child: loadImage(additionalImages[i]),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Container for product details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: loadImage(productData['image_url'] ?? ''),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productData['name'] ?? 'Nama tidak tersedia',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Rp. ${productData['price']?.toString() ?? '0'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Display the size from Firebase
                      Row(
                        children: [
                          Text(
                            'Ukuran: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            productData['size']?.toString() ?? 'N/A',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Quantity selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Kuantitas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: decrementQuantity,
                                icon: const Icon(Icons.remove),
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: incrementQuantity,
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Add to Cart button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Get the AuthController instance
                            final AuthController authController =
                                Get.find<AuthController>();

                            // Call the addToCart method
                            await authController.addToCart(
                                productData, quantity);

                            // Navigate to KeranjangView after successful addition
                            Get.to(() => KeranjangView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B4513),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Tambahkan Keranjang',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
