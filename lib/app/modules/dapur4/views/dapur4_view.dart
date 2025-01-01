import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/interiorkesukses/views/interiorkesukses_view.dart';

class dapur4View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F8), // Consistent background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Color(0xFF562B08)), // Match previous views
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Auropa',
          style: TextStyle(
            color: Color(0xFF562B08), // Match title color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/LOGO_YUMANSA.png', // Ensure logo is in the assets folder
              height: 40,
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFFFF0),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/dapur4.jpg', // Pastikan gambar ada di folder assets
                  height: 180.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Elegan dan modern, dapur ini memadukan estetika kontemporer dengan material alami. Dinding kayu putih dan elemen gelap pada countertop memberikan kontras yang memikat, sementara kursi bar minimalis menambah kesan chic. Pencahayaan yang hangat melengkapi suasana, menghadirkan ruang yang sempurna untuk gaya hidup masa kini.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: Color(0xFF562B08),
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Kursi ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF562B08),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildSizeInput()),
                    SizedBox(width: 8),
                    Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    SizedBox(width: 8),
                    Expanded(child: _buildSizeInput()),
                    SizedBox(width: 8),
                    Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    SizedBox(width: 8),
                    Expanded(child: _buildSizeInput()),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Meja ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF562B08),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildSizeInput()),
                    SizedBox(width: 8),
                    Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    SizedBox(width: 8),
                    Expanded(child: _buildSizeInput()),
                    SizedBox(width: 8),
                    Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    SizedBox(width: 8),
                    Expanded(child: _buildSizeInput()),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman berikutnya
                      Get.to(() => InteriorSuksesView());
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF562B08),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create custom button
  Widget _buildCustomLabel(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Function to create size input
  Widget _buildSizeInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8), // Tambahkan vertical
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'cm',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14), // Ukuran teks lebih kecil
      ),
    );
  }
}
