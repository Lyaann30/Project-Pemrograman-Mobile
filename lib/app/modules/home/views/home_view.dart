import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/welcome/views/welcome_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Simulasi delay untuk splash screen
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(WelcomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Logo.png', // Pastikan path sesuai dengan pubspec.yaml
          width: 300,
          height: 300,
          fit: BoxFit.contain, // Sesuaikan gambar
        ),
      ),
    );
  }
}
