import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/auth_controller.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';
import 'package:myapp/app/modules/profileinfo/views/profileinfo_view.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 390,
                height: 850,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFF562B08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 147,
                      top: 85,
                      child: Container(
                        width: 96,
                        height: 94,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://via.placeholder.com/96x94"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      top: 190,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ProfileInfoView());
                        },
                        child: Container(
                          width: 110,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Color(0xFF941B00),
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 246,
                      child: Container(
                        width: 390,
                        height: 617,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFFFF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(61),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 139,
                      top: 729,
                      child: GestureDetector(
                        onTap: () {
                          authController.signOut();
                          Get.to(() => HomeView());
                        },
                        child: Container(
                          width: 111,
                          height: 58,
                          decoration: ShapeDecoration(
                            color: Color(0xFF941B00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFFFF0),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 306,
                      child: _buildProfileItem(
                        'Nama: ${authController.userData['nama'] ?? ''}',
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 389,
                      child: _buildProfileItem(
                        'Email: ${authController.userData['email'] ?? ''}',
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 472,
                      child: _buildProfileItem(
                        'No. HP: ${authController.userData['no_hp'] ?? ''}',
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 555,
                      child: _buildProfileItem(
                        'Alamat: ${authController.userData['alamat'] ?? ''}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            top: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.to(() =>
                const HomePage());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String text) {
    return Container(
      width: 336,
      height: 68,
      decoration: ShapeDecoration(
        color: Color(0x21D9D9D9),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFF941B00)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF941B00),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
