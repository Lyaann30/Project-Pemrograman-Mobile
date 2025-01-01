import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/routes/app_pages.dart';

class HomeView extends GetView<LoginRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBF5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/LOGO_YUMANSA.png', height: 100),
              SizedBox(height: 20),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text(
                  'Daftar',
                  style: TextStyle(color: Colors.white), 
                ),
                onPressed: () => Get.toNamed(Routes.REGISTER),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(86, 43, 8, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(
                  'Masuk',
                  style: TextStyle(color: Colors.white), 
                ),
                onPressed: () => Get.toNamed('/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 140, 0, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginRegisterController extends GetxController {
  // Controller logic if needed
}