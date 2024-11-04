import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
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
                    Transform.translate(
                      offset: Offset(0, -40),
                      child: Image.asset('assets/Logo.png', height: 180),
                    ),
                    Transform.translate(
                      offset: Offset(0, -40),
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
                          // Input password dengan ikon visibility
                          Obx(() => TextField(
                                controller: passwordController,
                                obscureText: !authController.isPasswordVisible
                                    .value, // Kontrol visibility
                                decoration: InputDecoration(
                                  labelText: 'Masukkan password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      authController.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed:
                                        authController.togglePasswordVisibility,
                                  ),
                                ),
                              )),
                          SizedBox(height: 15),

                          // Tombol Login
                          ElevatedButton(
                            onPressed: () async {
                              bool success = await authController.loginUser(
                                usernameController.text,
                                passwordController.text,
                              );

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

                          // Link Register Now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              TextButton(
                                onPressed: () {
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
