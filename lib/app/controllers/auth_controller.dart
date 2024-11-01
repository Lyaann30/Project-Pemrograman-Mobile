import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kirim email verifikasi
      await userCredential.user?.sendEmailVerification();

      Get.snackbar(
        'Success',
        'Registration successful! Please verify your email before logging in.',
        backgroundColor: Colors.green,
      );

      // Arahkan ke halaman login setelah pendaftaran
      Get.off(LoginView());
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi Login
  Future<bool> loginUser(String email, String password) async {
  try {
    // Proses login ke Firebase dengan email dan password
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Cek status verifikasi email
    if (userCredential.user?.emailVerified ?? false) {
      // Jika email sudah diverifikasi, simpan status login di SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'your_token_value');

      Get.snackbar('Success', 'Login successful', backgroundColor: Colors.green);

      // Jika berhasil login, arahkan ke HOME
      return true; // Menandakan bahwa login berhasil
    } else {
      // Jika email belum diverifikasi, beri tahu pengguna
      Get.snackbar(
        'Verification Needed',
        'Please verify your email to log in. A verification email has been sent.',
        backgroundColor: Colors.orange,
      );

      // Kirim ulang email verifikasi
      await userCredential.user?.sendEmailVerification();

      // Logout agar sesi tidak disimpan
      await _auth.signOut();
      return false; // Menandakan bahwa login gagal
    }
  } on FirebaseAuthException catch (e) {
    // Tangani berbagai jenis kesalahan
    if (e.code == 'user-not-found') {
      Get.snackbar('Error', 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Get.snackbar('Error', 'Wrong password provided for that user.');
    } else if (e.code == 'invalid-email') {
      Get.snackbar('Error', 'The email format is invalid.');
    } else if (e.code == 'user-disabled') {
      Get.snackbar('Error', 'This user has been disabled.');
    } else {
      Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
    }
    return false; // Menandakan bahwa login gagal
  } catch (e) {
    Get.snackbar('Error', 'An unexpected error occurred.');
    return false; // Menandakan bahwa login gagal
  }
}

  // Fungsi Logout
  void logout() async {
    await _auth.signOut();

    // Hapus token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Arahkan ke halaman login
    Get.offAllNamed(Routes.LOGIN);
  }

  // Fungsi untuk menyimpan/memperbarui data profil pengguna
  Future<void> saveUserProfile(Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('profil')
          .doc('userId')
          .set(data, SetOptions(merge: true));
      Get.snackbar("Sukses", "Profil berhasil disimpan");
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan profil: $e");
    }
  }

  // Fungsi untuk mengambil data profil pengguna
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('profil').doc('userId').get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil profil: $e");
      return null;
    }
  }
}
