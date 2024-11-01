import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/forgot_pw/views/forgot_pw_view.dart';
import 'package:myapp/app/modules/register/views/register_view.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        // Membungkus dengan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    // Menggunakan Transform untuk menggeser logo ke atas
                    Transform.translate(
                      offset: Offset(0, -40), // Menggeser logo ke atas
                      child: Image.asset('assets/Logo.png', height: 180),
                    ),
                    // Menggunakan Transform untuk menggeser teks dan input
                    Transform.translate(
                      offset: Offset(0, -40), // Menggeser ke atas
                      child: Column(
                        children: [
                          Text(
                            'Masukkan username dan password untuk login',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          // Input username
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Masukkan email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Input password
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Masukkan password',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.visibility_off),
                            ),
                          ),
                          SizedBox(height: 15),

                          // Tombol Login
                          ElevatedButton(
                            onPressed: () async {
                              // Memanggil fungsi loginUser dari AuthController
                              bool success = await authController.loginUser(
                                usernameController.text,
                                passwordController.text,
                              );

                              // Jika login berhasil, navigasi ke AllbrandView
                              if (success) {
                                Get.to(() => AllbrandView());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8B4513),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 140, vertical: 15),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),

                          // Link Lupa Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigasi ke halaman lupa password
                                Get.to(() => ForgotPwView());
                              },
                              child: Text(
                                'lupa password?',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),
                          ),

                          // Link Register Now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              TextButton(
                                onPressed: () {
                                  // Navigasi ke halaman register
                                  Get.to(() => RegisterView());
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
