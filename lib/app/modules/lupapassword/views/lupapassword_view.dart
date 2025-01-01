import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/passwordbaru/views/passwordbaru_view.dart';

class LupaPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBF5), // Warna latar belakang sesuai gambar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // Navigasi kembali
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80), // Mengatur jarak agar inputan email berada di tengah
              Center(
                child: Image.asset(
                  'assets/LOGO_YUMANSA.png', // Logo sesuai gambar
                  height: 100,
                ),
              ),
              SizedBox(height: 40), // Menambah jarak antara logo dan teks
              Text(
                "Masukkan Email Anda",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildTextField("Email"),
              SizedBox(height: 50), // Memberi jarak tambahan antara inputan email dan tombol
              ElevatedButton(
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Get.to(() => PasswordBaruView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF562B08), // Warna tombol coklat
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.brown, fontSize: 12),
                    children: [
                      TextSpan(text: 'Dengan mendaftar, anda menyetujui\n'),
                      TextSpan(
                        text: 'aturan penggunaan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Warna merah untuk teks ini
                        ),
                      ),
                      TextSpan(text: ' dan '),
                      TextSpan(
                        text: 'kebijakan privasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Warna merah untuk teks ini
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk TextField Email
  Widget _buildTextField(String label) {
    return TextField(
      style: TextStyle(color: Colors.brown),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.brown),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.brown, width: 2),
        ),
      ),
    );
  }
}
