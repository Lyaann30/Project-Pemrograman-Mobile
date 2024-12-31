import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPesananView extends StatelessWidget {
  const AdminPesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan User',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('checkout').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak ada pesanan yang ditemukan'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // Mengecek apakah field 'product' adalah list atau map
              var products = orderData['product'];
              List<dynamic> productList = [];

              if (products is List) {
                productList = products;
              } else if (products is Map) {
                productList = [products];
              }

              return orderItem(
                idPesanan: snapshot.data!.docs[index].id,
                tanggalPembelian: orderData['timestamp'].toDate(),
                nameUser: orderData['nameUser'] ?? 'Tidak tersedia',
                address: orderData['address'] ?? 'Tidak tersedia',
                phone: orderData['phone'] ?? 'Tidak tersedia',
                shippingOption: orderData['shippingOption'] ?? 'Tidak tersedia',
                paymentMethod: orderData['paymentMethod'] ?? 'Tidak tersedia',
                total: 'Rp. ${orderData['total']?.toString() ?? '0'}',
                products: productList,
              );
            },
          );
        },
      ),
    );
  }

  Widget orderItem({
    required String idPesanan,
    required DateTime tanggalPembelian,
    required String nameUser,
    required String address,
    required String phone,
    required String shippingOption,
    required String paymentMethod,
    required String total,
    required List<dynamic> products,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id Pesanan: $idPesanan',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Tanggal Pembelian: ${tanggalPembelian.toLocal()}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Nama: $nameUser',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Nomor Telepon: $phone',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Alamat: $address',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            // Menampilkan produk
            ...products.map((product) {
              return Row(
                children: [
                  // Gambar produk
                  loadImage(product['imageUrl'], 100, 100), // Gambar lebih besar
                  const SizedBox(width: 12), // Jarak antara gambar dan teks
                  // Data produk
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Barang: ${product['nameProduct']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Harga: Rp. ${product['price']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Ukuran: ${product['size']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Kuantitas: ${product['quantity']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 8),
            Text(
              'Opsi Pengiriman: $shippingOption',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Metode Pembayaran: $paymentMethod',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Total Harga: $total',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to load image based on `image_url`
  Widget loadImage(String imagePath, double width, double height) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child; // Gambar selesai dimuat
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text('Gambar tidak dapat dimuat'));
        },
      );
    }
  }
}
