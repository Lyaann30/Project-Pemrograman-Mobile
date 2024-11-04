import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart'; // Import controller yang sudah dibuat
import 'package:myapp/app/modules/new_pw/views/new_pw_view.dart';
import 'package:myapp/app/modules/welcome/views/welcome_view.dart';

class ForgotPwView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Inisialisasi AuthController
  final TextEditingController emailController = TextEditingController(); // Controller untuk input email

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
      body: SingleChildScrollView(
        // Menambahkan SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Transform.translate(
                  offset: Offset(0, -40), // Menggeser logo ke atas
                  child: Image.asset('assets/Logo.png', height: 180),
                ),

                // Teks 'Reset Password'
                Transform.translate(
                  offset: Offset(0, -20), // Menggeser teks ke atas
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

                // Deskripsi
                Transform.translate(
                  offset: Offset(0, -10), // Menggeser deskripsi ke atas
                  child: Text(
                    'Reset menggunakan email',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),

                // Input Email
                Transform.translate(
                  offset: Offset(0, -10), // Menggeser input email ke atas
                  child: TextField(
                    controller: emailController, // Set controller untuk TextField
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Tombol Next dan Cancel
                Transform.translate(
                  offset: Offset(0, -20), // Menggeser row tombol ke atas
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Memanggil fungsi reset password dari AuthController
                          String email = emailController.text;
                          await authController.sendPasswordResetEmail(email);
                          // Arahkan ke halaman new password setelah mengirim email
                          Get.to(NewPwView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B4513), // Warna tombol coklat
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          // Aksi ketika tombol Cancel ditekan
                          Get.to(WelcomeView());
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          side: BorderSide(color: Colors.black54),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
