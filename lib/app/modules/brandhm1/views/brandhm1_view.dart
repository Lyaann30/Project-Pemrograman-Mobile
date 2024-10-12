import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/alamat_tagihan/views/alamat_tagihan_view.dart';
import 'package:myapp/app/modules/keranjang_hm1/views/keranjang_hm1_view.dart';

class Brandhm1View extends StatefulWidget {
  @override
  _Brandhm1ViewState createState() => _Brandhm1ViewState();
}

class _Brandhm1ViewState extends State<Brandhm1View> {
  int _selectedSize = 39; // Menyimpan ukuran yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar sepatu
            Container(
              height: 300,
              child: Image.asset(
                'assets/HandyMen 204 Sepatu Formal Kulit.png', // Ganti dengan URL gambar asli
                fit: BoxFit.cover,
              ),
            ),
            // Pilihan gambar tambahan di bawah gambar utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(-30, 0),
                      child: Image.asset(
                        'assets/HM 204 (1).png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    Transform.translate(
                      offset: const Offset(-100, 0),
                      child: Image.asset(
                        'assets/HM 204 (2).png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    Transform.translate(
                      offset: const Offset(-170, 0),
                      child: Image.asset(
                        'assets/HM 204 (3).png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    Transform.translate(
                      offset: const Offset(-240, 0),
                      child: Image.asset(
                        'assets/HM 204 (4).png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Nama produk dan harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Handymen 204 Sepatu Formal Kulit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp. 312.250',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ukuran Tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Tambahan: Ukuran sepatu dengan border, di tengah dengan jarak 20px
                  Center(
                    child: Wrap(
                      alignment:
                          WrapAlignment.center, // Menyusun item di tengah
                      spacing: 20, // Jarak antar ukuran sebesar 20px
                      children: List.generate(5, (index) {
                        int size = 39 + index;
                        bool isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize =
                                  size; // Mengubah ukuran yang dipilih
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xFF8B4513)
                                  : Colors
                                      .white, // Background coklat jika dipilih
                              border: Border.all(
                                  color: isSelected
                                      ? Color(0xFF8B4513)
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              size.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black, // Teks putih jika dipilih
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'slip on dress shoes berbahan Full grain leather '
                    'yang didesain elegant dengan laminating leather lining dan low heel outsole '
                    'sehingga tetap nyaman digunakan saat beraktivtas. ',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            // Tombol "Beli Sekarang" dengan latar belakang coklat di dalam border
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => AlamatTagihanView());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Border dan latar belakang untuk ikon keranjang
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            KeranjangHm1View()); // Navigasi ke halaman keranjang
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF8B4513), // Latar belakang coklat
                          border: Border.all(color: Color(0xFF8B4513)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white, // Agar ikon terlihat lebih jelas
                        ),
                      ),
                    ),
                    SizedBox(width: 80),
                    // Border dan latar belakang untuk teks "Beli Sekarang"
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF8B4513), // Latar belakang coklat
                        border: Border.all(color: Color(0xFF8B4513)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Beli Sekarang',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}