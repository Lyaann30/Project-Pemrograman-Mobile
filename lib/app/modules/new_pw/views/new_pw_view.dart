import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';

class NewPwView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Navigasi ke halaman sebelumnya
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Transform.translate(
                offset: Offset(0, -70), // Menggeser logo ke atas sebesar 40 px
                child: Image.asset('assets/Logo.png', height: 180),
              ),

              // Teks 'Reset Password'
              Transform.translate(
                offset: Offset(0, -50), // Menggeser teks ke atas sebesar 20 px
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Input Password Baru
              Transform.translate(
                offset: Offset(0, -10), 
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Masukkan Password Baru',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Input Nomor Telepon
              Transform.translate(
                offset: Offset(0, -10), // Menggeser input nomor telepon ke atas
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Tombol Next dan Cancel
              Transform.translate(
                offset: Offset(0, -20), // Menggeser row tombol ke atas
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(LoginView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B4513), // Warna tombol coklat
                        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
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
}
