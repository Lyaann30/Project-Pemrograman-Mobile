import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/suksesdaftar/views/success_registration_view.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Tambahkan Rx variables untuk menyimpan data user
  final Rx<User?> user = Rx<User?>(null);
  final RxMap<String, dynamic> userData = RxMap<String, dynamic>();

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user != null) {
      // Load user data ketika auth state berubah
      _loadUserData(user.uid);
    }
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        userData.value = doc.data() ?? {};
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Fungsi untuk registrasi
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
    String address,
    String phone,
  ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Menyimpan data pengguna ke Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'nama': name,
        'email': email,
        'alamat': address,
        'no_hp': phone,
      });
      
      // Load user data setelah registrasi
      if (userCredential.user != null) {
        await _loadUserData(userCredential.user!.uid);
      }

      Get.to(() => SuccessRegistrationView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Terjadi kesalahan",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk login
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Load user data setelah login
      if (userCredential.user != null) {
        await _loadUserData(userCredential.user!.uid);
      }
      
      Get.to(() => HomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Error",
        e.message ?? "Email atau password salah",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Tambahkan fungsi untuk update profile
  Future<bool> updateUserProfile({
    String? name,
    String? email,
    String? phone,
    String? address, File? profileImage,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final updates = {
          if (name != null) 'nama': name,
          if (email != null) 'email': email,
          if (phone != null) 'no_hp': phone,
          if (address != null) 'alamat': address,
        };

        await _firestore.collection('users').doc(currentUser.uid).update(updates);
        
        // Reload user data after update
        await _loadUserData(currentUser.uid);
        
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
        
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        "Error",
        "Failed to update profile",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Fungsi untuk logout
  Future<void> signOut() async {
    await _auth.signOut();
    userData.clear();
    Get.offAll(() => HomeView());
  }

  // Getter untuk mengecek apakah user sudah login
  bool get isLoggedIn => user.value != null;
}
 