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
  late Rx<User?> firebaseUser;

  // Menambahkan observable untuk password visibility
  RxBool isPasswordVisible = false.obs;

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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user?.emailVerified ?? false) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', 'your_token_value');

        Get.snackbar('Success', 'Login successful',
            backgroundColor: Colors.green);

        return true; // Menandakan bahwa login berhasil
      } else {
        Get.snackbar(
          'Verification Needed',
          'Please verify your email to log in. A verification email has been sent.',
          backgroundColor: Colors.orange,
        );

        await userCredential.user?.sendEmailVerification();
        await _auth.signOut();
        return false; // Menandakan bahwa login gagal
      }
    } on FirebaseAuthException catch (e) {
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

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Get.offAllNamed(Routes.LOGIN);
  }

  // Fungsi untuk menyimpan/memperbarui data profil pengguna
  Future<void> saveUserProfile(Map<String, dynamic> data) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore
            .collection('profil')
            .doc(currentUser.uid) // Menggunakan UID pengguna saat ini
            .set(data, SetOptions(merge: true));
        Get.snackbar("Sukses", "Profil berhasil disimpan");
      } else {
        Get.snackbar("Error", "Pengguna tidak ditemukan. Silakan login kembali.");
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan profil: $e");
    }
  }

  // Fungsi untuk mengambil data profil pengguna
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('profil').doc(currentUser.uid).get();
        return snapshot.data() as Map<String, dynamic>?;
      } else {
        Get.snackbar("Error", "Pengguna tidak ditemukan. Silakan login kembali.");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil profil: $e");
      return null;
    }
  }

  // Fungsi untuk mengirim email reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent!',
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email: $e',
          backgroundColor: Colors.red);
    }
  }

  // Fungsi untuk memperbarui password
  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        Get.snackbar('Success', 'Password berhasil diperbarui!',
            backgroundColor: Colors.green);
        Get.offAll(() => LoginView()); // Mengarahkan ke halaman login
      } else {
        Get.snackbar('Error', 'User tidak ditemukan. Silakan login kembali.',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui password: ${e.toString()}',
          backgroundColor: Colors.red);
    }
  }

  // Method untuk menambahkan atau memperbarui alamat pengguna
  Future<void> addAddress(String address) async {
    try {
      String? userId = firebaseUser.value?.uid;
      if (userId != null) {
        await _firestore.collection('users').doc(userId).update({
          'address': address,
        });
        Get.snackbar("Success", "Address updated successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  // Method untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
