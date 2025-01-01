import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';

class PasswordBaruView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5), // Sesuaikan dengan latar belakang yang diinginkan
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/LOGO_YUMANSA.png', height: 100), // Sesuaikan ukuran logo
              const SizedBox(height: 20),
              _buildPasswordField('Masukkan Password Baru'),
              _buildPasswordField('Konfirmasi Password Baru'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Get.to(() => LoginView());
                },
                child: const Text(
                  'Daftar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(86, 43, 8, 1), // Warna cokelat
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dengan mendaftar, anda menyetujui ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'aturan penggunaan ',
                      style: TextStyle(
                        color: Colors.brown,
                        decoration: TextDecoration.underline,
                      ),
                      // Aksi aturan penggunaan (sementara kosong)
                    ),
                    TextSpan(
                      text: 'dan ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'kebijakan privasi',
                      style: TextStyle(
                        color: Colors.brown,
                        decoration: TextDecoration.underline,
                      ),
                      // Aksi kebijakan privasi (sementara kosong)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: true, // Untuk menutupi password
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown, width: 2),
          ),
        ),
      ),
    );
  }
}
