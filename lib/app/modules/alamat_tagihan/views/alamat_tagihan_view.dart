import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/pesanan_sukses/views/pesanan_sukses_view.dart';
import '../controllers/alamat_tagihan_controller.dart';

class AlamatTagihanView extends StatefulWidget {
  final List<String> selectedItemIds;

  const AlamatTagihanView({super.key, required this.selectedItemIds});

  @override
  _AlamatTagihanViewState createState() => _AlamatTagihanViewState();
}

class _AlamatTagihanViewState extends State<AlamatTagihanView> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  String? _selectedShippingOption;
  String? _selectedAddress;
  String? _selectedPaymentMethod;
  
  double _shippingCost = 12000; // Default shipping cost
  
  final AuthController _authController = Get.find<AuthController>();
  List<Map<String, dynamic>> _savedAddresses = [];

  Widget _buildSelectedItemCard(Map<String, dynamic> item) {
    final price = parsePrice(item['price']);
    final quantity = parseQuantity(item['quantity']);
    final totalPrice = price * quantity;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: item['imageUrl'] != null
            ? loadImage(item['imageUrl'])
            : null,
        title: Text(item['name'] ?? 'Produk Tidak Dikenal'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga: ${formatRupiah(totalPrice)}'),
            Text('Ukuran: ${item['size'] ?? 'N/A'}'),
            Text('Jumlah: $quantity'),
          ],
        ),
      ),
    );
  }

  // Helper function to parse price safely
  double parsePrice(dynamic price) {
    if (price is String) {
      // Remove any thousand separators and replace comma with dot for decimal
      String cleanPrice = price.replaceAll('.', '').replaceAll(',', '.');
      return double.tryParse(cleanPrice) ?? 0.0;
    }
    return price?.toDouble() ?? 0.0;
  }

  // Helper function to format price in Rupiah
  String formatRupiah(double price) {
    // Convert to integer to remove decimal
    int priceInt = price.round();
    
    // Convert to string
    String priceString = priceInt.toString();
    
    // If price is less than 1000, return as is
    if (priceString.length <= 3) {
      return 'Rp. $priceString';
    }
    
    // Add thousand separators
    String formatted = '';
    for (int i = 0; i < priceString.length; i++) {
      if (i > 0 && (priceString.length - i) % 3 == 0) {
        formatted += '.';
      }
      formatted += priceString[i];
    }
    
    return 'Rp. $formatted';
  }

  // Helper function to parse quantity safely
  int parseQuantity(dynamic quantity) {
    if (quantity is String) {
      return int.tryParse(quantity) ?? 1;
    }
    return quantity ?? 1;
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedAddresses();
  }

  void _fetchSavedAddresses() {
    _authController.getAddresses().listen((addresses) {
      setState(() {
        _savedAddresses = addresses;
      });
    });
  }

  // Helper function to load image based on `image_url`
  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
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

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: const Center(child: Text("Silakan login terlebih dahulu")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alamat Pengiriman Section
            const Text(
              'Alamat Pengiriman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Alamat Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Alamat',
                border: OutlineInputBorder(),
              ),
              isExpanded: true, // This will help with text overflow
              value: _selectedAddress,
              items: _savedAddresses.map<DropdownMenuItem<String>>((address) {
                return DropdownMenuItem<String>(
                  value: address['address'],
                  child: Text(
                    '${address['address']}',
                    overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                    maxLines: 2, // Allow up to 2 lines
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAddress = value;
                  
                  // Find the full address details
                  final selectedAddressDetails = _savedAddresses.firstWhere(
                    (address) => address['address'] == value
                  );

                  // Populate controllers
                  _namaController.text = selectedAddressDetails['name'];
                  _phoneController.text = selectedAddressDetails['phone'];
                  _alamatController.text = selectedAddressDetails['address'];
                });
              },
            ),
            const SizedBox(height: 16),

            // Nama Lengkap Field
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Nomor Telepon Field
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor Telepon',
                hintText: 'Masukkan Nomor Telepon',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Alamat Field
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                hintText: 'Masukkan Alamat',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Selected Items Section
            const Text(
              'Produk yang Dipilih',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Fetch and display selected cart items
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where('uid', isEqualTo: user.uid)
                  .where(FieldPath.documentId, whereIn: widget.selectedItemIds)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Tidak ada produk yang dipilih"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return _buildSelectedItemCard(item);
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // Shipping Option
            const Text(
              'Opsi Pengiriman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Opsi Pengiriman',
                border: OutlineInputBorder(),
              ),
              value: _selectedShippingOption,
              items: [
                DropdownMenuItem(
                  value: 'standar',
                  child: const Text('Pengiriman Standar (+ 12.000)'),
                  onTap: () {
                    setState(() {
                      _shippingCost = 12000;
                      _selectedShippingOption = 'standar';
                    });
                  },
                ),
                DropdownMenuItem(
                  value: 'express',
                  child: const Text('Pengiriman Express (+ 20.000)'),
                  onTap: () {
                    setState(() {
                      _shippingCost = 20000;
                      _selectedShippingOption = 'express';
                    });
                  },
                ),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Payment Options
            const Text(
              'Opsi Pembayaran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Bank',
                border: OutlineInputBorder(),
              ),
              value: _selectedPaymentMethod,
              items: [
                const DropdownMenuItem(
                  value: 'Transfer Bank',
                  child: Text('Transfer Bank'),
                ),
                DropdownMenuItem(
                  value: 'BRI',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LOGO BRI.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text('Bank BRI'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'BCA',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LOGO BCA.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text('Bank BCA'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'BNI',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LOGO BNI.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text('Bank BNI'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Mandiri',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LOGO MANDIRI.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text('Bank Mandiri'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'BSI',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LOGO BSI.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text('Bank Syariah Indonesia'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Payment Summary
            _buildPaymentSummary(user.uid),

            const SizedBox(height: 16),

            //Order Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (_namaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama lengkap harus diisi'))
                    );
                    return;
                  }

                  if (_phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nomor telepon harus diisi'))
                    );
                    return;
                  }

                  if (_alamatController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Alamat harus diisi'))
                    );
                    return;
                  }

                  if (_selectedShippingOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih opsi pengiriman'))
                    );
                    return;
                  }

                  if (_selectedPaymentMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih metode pembayaran'))
                    );
                    return;
                  }

                  // Call checkout method
                  _authController.checkout(
                    selectedItemIds: widget.selectedItemIds,
                    shippingOption: _selectedShippingOption!,
                    paymentMethod: _selectedPaymentMethod!,
                    name: _namaController.text,
                    phone: _phoneController.text,
                    address: _alamatController.text,
                  ).then((_) {
                    // Navigate to success page
                    Get.to(PesananSuksesView());
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Pesan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Previous methods like _buildSelectedItemCard, _buildPaymentSummary remain the same
  Widget _buildPaymentSummary(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cart')
          .where('uid', isEqualTo: userId)
          .where(FieldPath.documentId, whereIn: widget.selectedItemIds)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        // Calculate subtotal
        double subtotal = snapshot.data!.docs.fold(0, (total, doc) {
          final item = doc.data() as Map<String, dynamic>;
          final price = parsePrice(item['price']);
          final quantity = parseQuantity(item['quantity']);
          return total + (price * quantity);
        });

        // Total calculation including shipping
        double total = subtotal + _shippingCost;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.receipt, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Rincian Pembelian',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _summaryRow('Sub-total', formatRupiah(subtotal)),
              const SizedBox(height: 8),
              _summaryRow('Biaya Pengiriman', formatRupiah(_shippingCost)),
              const Divider(),
              _summaryRow(
                'Total Pembayaran',
                formatRupiah(total),
                isBold: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryRow(String title, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 16,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 16,
          ),
        ),
      ],
    );
  }
}