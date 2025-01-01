import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';

class InteriorSuksesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFF0), // Latar belakang sesuai dengan Dapur5View
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 279, // Ukuran disesuaikan
                height: 336, // Ukuran disesuaikan
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF562B08), // Warna coklat tua sesuai Dapur5View
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 118,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFF0), // Warna putih sesuai dengan Dapur5View
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 155, 52, 12), // Warna ikonnya disesuaikan
                        size: 83, // Ukuran ikon disesuaikan
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Success !',
                      style: TextStyle(
                        color: Color(0xFFFFFFF0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 181,
                      child: Text(
                        'Orderanmu sudah diterima dan akan kami hubungi kembali melalui email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFFFF0),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman HomePage
                  Get.to(() => HomePage());
                },
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    color: Color(0xFFFFFFF0),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF562B08), // Warna tombol sesuai dengan Dapur5View
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Sesuai dengan Dapur5View
                  ),
                  shadowColor: Color(0x3F000000), // Sesuai dengan shadow dari Dapur5View
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}