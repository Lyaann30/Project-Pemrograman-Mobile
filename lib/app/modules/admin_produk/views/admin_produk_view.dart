import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProdukView extends StatefulWidget {
  @override
  _AdminProdukViewState createState() => _AdminProdukViewState();
}

class _AdminProdukViewState extends State<AdminProdukView> {
  final AuthController authController = Get.find<AuthController>();
  String _selectedBrand = 'All';
  String? _selectedMainImage;
  String? _selectedImage1;
  String? _selectedImage2;
  String? _selectedImage3;
  String? _selectedImage4;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Daftar gambar yang tersedia di assets
  final List<String> assetImages = [
    'assets/ForMen AF 101 Sepatu Loafers Kulit.png',
    'assets/ForMen AF 104 Sepatu Loafers Kulit.png',
    'assets/Handymen 204 Sepatu Formal Kulit.png',
    'assets/Handymen 971 Sepatu Safety Pendek.png',
    'assets/Mr.Show 501 Sepatu Formal Kulit.png',
    'assets/Mr.Show 502 Sepatu Formal Kulit.png',
    'assets/Vindys Lawender 502 Mid Heels Formal Shoes.png',
    'assets/Vindys Lawender 503 Mid Heels Formal Shoes.png',
    'assets/FM AF 101 (1).png',
    'assets/FM AF 101 (2).png',
    'assets/FM AF 101 (3).png',
    'assets/FM AF 101 (4).png',
    'assets/FM AF 104 (1).png',
    'assets/FM AF 104 (2).png',
    'assets/FM AF 104 (3).png',
    'assets/FM AF 104 (4).png',
    'assets/HM 204 (1).png',
    'assets/HM 204 (2).png',
    'assets/HM 204 (3).png',
    'assets/HM 204 (4).png',
    'assets/HM 971 (1).png',
    'assets/HM 971 (2).png',
    'assets/HM 971 (3).png',
    'assets/HM 971 (4).png',
    'assets/MS 501 (1).png',
    'assets/MS 501 (2).png',
    'assets/MS 501 (3).png',
    'assets/MS 501 (4).png',
    'assets/MS 502 (1).png',
    'assets/MS 502 (2).png',
    'assets/MS 502 (3).png',
    'assets/MS 502 (4).png',
    'assets/V 502 (1).png',
    'assets/V 502 (2).png',
    'assets/V 502 (3).png',
    'assets/V 502 (4).png',
    'assets/V 503 (1).png',
    'assets/V 503 (2).png',
    'assets/V 503 (3).png',
    'assets/V 503 (4).png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Produk'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  brandLogo('All', 'assets/Logo All Brand.png', logoSize: 20),
                  brandLogo('Hm', 'assets/Logo Brand Hm.png', logoSize: 20),
                  brandLogo('Fm', 'assets/Logo Brand Fm.png', logoSize: 20),
                  brandLogo('Mr.Show', 'assets/Logo Brand Ms.png', logoSize: 20),
                  brandLogo('Vindys', 'assets/Logo Brand Vs.png', logoSize: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _buildBrandContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAddProductDialog(context);
            },
          );
        },
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Metode _buildBrandContent untuk menampilkan produk sesuai brand yang dipilih
  Widget _buildBrandContent() {
  return StreamBuilder<List<Map<String, dynamic>>>(
    stream: _fetchProductsByBrand(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No products available.'));
      }

      final products = snapshot.data!;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      product['image_url'],
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Rp. ${product['price'].toStringAsFixed(3)}'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Ukuran: ${product['size']}'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Stok: ${product['stock']}'),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.translate(
                            offset: Offset(15, 0), // Menggeser posisi ikon edit lebih ke kanan
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                _showEditProductDialog(product);
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints(),
                            onPressed: () {
                              _deleteProduct(product['docId']);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  // Mengambil daftar produk sesuai brand yang dipilih
  Stream<List<Map<String, dynamic>>> _fetchProductsByBrand() {
  return FirebaseFirestore.instance
      .collection('products')
      .where('brand', isEqualTo: _selectedBrand == 'All' ? null : _selectedBrand)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            data['docId'] = doc.id; // Menyertakan docId sebagai bagian dari data
            return data;
          }).toList());
  }

  // Fungsi untuk mengosongkan semua field dan variabel gambar
  void clearFields() {
    _productNameController.clear();
    _priceController.clear();
    _stockController.clear();
    _sizeController.clear();
    _descriptionController.clear();
    
    // Mengosongkan variabel gambar
    _selectedMainImage = null;
    _selectedImage1 = null;
    _selectedImage2 = null;
    _selectedImage3 = null;
    _selectedImage4 = null;
  }

  // Dialog untuk menambahkan produk
  Widget _buildAddProductDialog(BuildContext context) {
    clearFields(); // Kosongkan semua field sebelum dialog muncul

    return AlertDialog(
      title: Text('Tambah Produk'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(labelText: 'Ukuran Sepatu'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String? selectedImage = await _pickImage();
                setState(() {
                  _selectedMainImage = selectedImage;
                });
              },
              child: Text('Pilih Gambar Utama'),
            ),
            if (_selectedMainImage != null) Image.asset(_selectedMainImage!, height: 100),

            // Pilih Gambar 1
            ElevatedButton(
              onPressed: () async {
                String? selectedImage = await _pickImage();
                setState(() {
                  _selectedImage1 = selectedImage;
                });
              },
              child: Text('Pilih Gambar 1'),
            ),
            if (_selectedImage1 != null) Image.asset(_selectedImage1!, height: 100),

            // Pilih Gambar 2
            ElevatedButton(
              onPressed: () async {
                String? selectedImage = await _pickImage();
                setState(() {
                  _selectedImage2 = selectedImage;
                });
              },
              child: Text('Pilih Gambar 2'),
            ),
            if (_selectedImage2 != null) Image.asset(_selectedImage2!, height: 100),

            // Pilih Gambar 3
            ElevatedButton(
              onPressed: () async {
                String? selectedImage = await _pickImage();
                setState(() {
                  _selectedImage3 = selectedImage;
                });
              },
              child: Text('Pilih Gambar 3'),
            ),
            if (_selectedImage3 != null) Image.asset(_selectedImage3!, height: 100),

            // Pilih Gambar 4
            ElevatedButton(
              onPressed: () async {
                String? selectedImage = await _pickImage();
                setState(() {
                  _selectedImage4 = selectedImage;
                });
              },
              child: Text('Pilih Gambar 4'),
            ),
            if (_selectedImage4 != null) Image.asset(_selectedImage4!, height: 100),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            _saveProduct();
            Get.back();
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }

  // Method untuk menyimpan produk ke Firestore
  void _saveProduct() {
    final productData = {
      'name': _productNameController.text,
      'price': double.tryParse(_priceController.text) ?? 0,
      'stock': int.tryParse(_stockController.text) ?? 0,
      'size': _sizeController.text,
      'description': _descriptionController.text,
      'image_url': _selectedMainImage ?? 'assets/image.png',
      'additional_images': [
        _selectedImage1,
        _selectedImage2,
        _selectedImage3,
        _selectedImage4,
      ].whereType<String>().toList(), // Filter elemen null
      'brand': _selectedBrand,
    };
    authController.addProduct(productData);
  }

  // Dialog untuk mengedit produk
  void _showEditProductDialog(Map<String, dynamic> product) {
    _productNameController.text = product['name'];
    _priceController.text = product['price'].toString();
    _stockController.text = product['stock'].toString();
    _sizeController.text = product['size'];
    _descriptionController.text = product['description'];
    _selectedMainImage = product['image_url'];
    _selectedImage1 = product['additional_images']?[0];
    _selectedImage2 = product['additional_images']?[1];
    _selectedImage3 = product['additional_images']?[2];
    _selectedImage4 = product['additional_images']?[3];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Produk'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: 'Nama Produk'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: 'Stok'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _sizeController,
                  decoration: InputDecoration(labelText: 'Ukuran Sepatu'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String? selectedImage = await _pickImage();
                    setState(() {
                      _selectedMainImage = selectedImage;
                    });
                  },
                  child: Text('Pilih Gambar Utama'),
                ),
                if (_selectedMainImage != null) Image.asset(_selectedMainImage!, height: 100),

                // Pilih Gambar 1
                ElevatedButton(
                  onPressed: () async {
                    String? selectedImage = await _pickImage();
                    setState(() {
                      _selectedImage1 = selectedImage;
                    });
                  },
                  child: Text('Pilih Gambar 1'),
                ),
                if (_selectedImage1 != null) Image.asset(_selectedImage1!, height: 100),

                // Pilih Gambar 2
                ElevatedButton(
                  onPressed: () async {
                    String? selectedImage = await _pickImage();
                    setState(() {
                      _selectedImage2 = selectedImage;
                    });
                  },
                  child: Text('Pilih Gambar 2'),
                ),
                if (_selectedImage2 != null) Image.asset(_selectedImage2!, height: 100),

                // Pilih Gambar 3
                ElevatedButton(
                  onPressed: () async {
                    String? selectedImage = await _pickImage();
                    setState(() {
                      _selectedImage3 = selectedImage;
                    });
                  },
                  child: Text('Pilih Gambar 3'),
                ),
                if (_selectedImage3 != null) Image.asset(_selectedImage3!, height: 100),

                // Pilih Gambar 4
                ElevatedButton(
                  onPressed: () async {
                    String? selectedImage = await _pickImage();
                    setState(() {
                      _selectedImage4 = selectedImage;
                    });
                  },
                  child: Text('Pilih Gambar 4'),
                ),
                if (_selectedImage4 != null) Image.asset(_selectedImage4!, height: 100),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Batal'),
            ),
          ElevatedButton(
            onPressed: () async {
              final updatedData = {
                'name': _productNameController.text,
                'price': double.tryParse(_priceController.text) ?? 0,
                'stock': int.tryParse(_stockController.text) ?? 0,
                'size': _sizeController.text,
                'description': _descriptionController.text,
                'image_url': _selectedMainImage ?? 'assets/image.png',
                'additional_images': [
                  _selectedImage1,
                  _selectedImage2,
                  _selectedImage3,
                  _selectedImage4,
                ].whereType<String>().toList(),
              };
              
              print('docId for edit: ${product['docId']}'); // Debug print untuk memeriksa docId
              await authController.editProduct(product['docId'], updatedData);
              Get.back();
            },
            child: Text('Simpan'),
          ),
        ],
        );
      },
    );
  }

  // Menghapus produk
  void _deleteProduct(String docId) async {
    print('docId for delete: $docId'); // Debug print untuk memeriksa docId
    await authController.deleteProduct(docId);
  }

  // Memilih gambar dari assets
  Future<String?> _pickImage() async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Gambar'),
          content: SingleChildScrollView(
            child: Column(
              children: assetImages.map((imagePath) {
                return ListTile(
                  leading: Image.asset(imagePath, width: 50),
                  title: Text(imagePath.split('/').last),
                  onTap: () => Navigator.of(context).pop(imagePath),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Widget untuk ikon brand
  Widget brandLogo(String brandName, String imagePath, {double logoSize = 30}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBrand = brandName;
        });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _selectedBrand == brandName ? Colors.red : Color(0xFF8B4513), width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: logoSize,
            ),
          ),
        ),
      ),
    );
  }
}
