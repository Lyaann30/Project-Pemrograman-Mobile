import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Navigasi ke halaman sebelumnya
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start, // Memastikan elemen di atas
          children: <Widget>[
            // Menggunakan Transform untuk menggeser logo ke atas
            Transform.translate(
              offset: Offset(0, -30), // Menggeser logo ke atas sebesar 30 px
              child: Image.asset('assets/Logo.png', height: 180),
            ),

            // Menggunakan Transform untuk menggeser teks "Register"
            Transform.translate(
              offset: Offset(0, -40), // Menggeser teks "Register" ke atas (ubah nilai Y sesuai kebutuhan)
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 0),

            // Menggunakan Transform untuk menggeser semua TextField dan tombol
            Transform.translate(
              offset: Offset(0, -20), // Menggeser ke atas sebesar 30 px
              child: Column(
                children: [
                  // Input Username
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Input Email
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Input Password
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // Input Confirm Password
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  // Tombol Konfirmasi
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B4513),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 80.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // Navigasi ke halaman baru setelah klik "Confirm"
                      Get.to(LoginView()); // Mengarah ke halaman baru
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
