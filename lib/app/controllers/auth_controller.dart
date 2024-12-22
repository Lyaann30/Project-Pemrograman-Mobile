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
  RxBool isPasswordVisible = false.obs;
  RxList<Map<String, dynamic>> faqList = <Map<String, dynamic>>[].obs;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  // Fungsi Register
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

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'your_token_value');

    Get.snackbar('Success', 'Login successful',
        backgroundColor: Colors.green);

    // Cek apakah user adalah admin
    if (email == 'admin@example.com' && password == 'admin123') {
      // Arahkan ke halaman AdminHomeView tanpa perlu verifikasi email
      Get.offAllNamed(Routes.ADMIN_HOME); // Ganti dengan rute ke AdminHomeView
    } else {
      // Cek apakah email telah diverifikasi untuk pengguna biasa
      if (userCredential.user?.emailVerified ?? false) {
        // Arahkan ke halaman biasa
        Get.offAllNamed(Routes.ALLBRAND); // Ganti dengan rute ke halaman pengguna biasa
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
    }
    return true; // Menandakan bahwa login berhasil
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

  // Menambahkan alamat
  Future<void> addAddress(String name, String phone, String address) async {
  try {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Menambahkan alamat baru ke koleksi 'addresses' pengguna
      await _firestore.collection('addresses').add({
        'uid': currentUser.uid,
        'name': name,
        'phone': phone,
        'address': address,
        'label': 'Lainnya',  // Anda bisa menambahkan label sesuai keinginan
        'createdAt': FieldValue.serverTimestamp(), // Menyimpan waktu alamat ditambahkan
      });

      Get.snackbar("Sukses", "Alamat berhasil ditambahkan.");
    }
  } catch (e) {
    Get.snackbar("Error", "Gagal menambahkan alamat: $e");
  }
}

  // Mengedit alamat
  Future<void> editAddress(String docId, String name, String phone, String address) async {
  try {
    DocumentSnapshot docSnapshot = await _firestore.collection('addresses').doc(docId).get();
    if (docSnapshot.exists) {
      await _firestore.collection('addresses').doc(docId).update({
        'name': name,
        'phone': phone,
        'address': address,
      });
      Get.snackbar("Sukses", "Alamat berhasil diperbarui.");
    } else {
      Get.snackbar("Error", "Alamat tidak ditemukan.");
    }
  } catch (e) {
    Get.snackbar("Error", "Gagal memperbarui alamat: $e");
  }
}

  // Menghapus alamat
  Future<void> deleteAddress(String docId) async {
  try {
    await FirebaseFirestore.instance
        .collection('addresses')
        .doc(docId)
        .delete();
    Get.snackbar("Sukses", "Alamat berhasil dihapus.");
  } catch (e) {
    Get.snackbar("Error", "Gagal menghapus alamat: $e");
  }
}


  // Menyimpan alamat ke Firestore
  Future<void> saveAddress(String name, String phone, String address) async {
  try {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Menambahkan alamat ke koleksi 'addresses' pengguna
      await _firestore.collection('addresses').add({
        'uid': currentUser.uid,
        'name': name,
        'phone': phone,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Sukses", "Alamat berhasil ditambahkan.");
    }
  } catch (e) {
    Get.snackbar("Error", "Gagal menambahkan alamat: $e");
  }
}

  // Mengambil alamat berdasarkan UID pengguna
  Stream<List<Map<String, dynamic>>> getAddresses() {
  return FirebaseFirestore.instance
      .collection('addresses')
      .where('uid', isEqualTo: _auth.currentUser?.uid)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data();
      data['docId'] = doc.id;  // Menyertakan docId
      return data;
    }).toList();
  });
}

  // Method untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  // Fungsi untuk mengambil data FAQ dari Firestore
  void fetchFaqs() {
    _firestore.collection('faq').snapshots().listen((snapshot) {
      faqList.value = snapshot.docs.map((doc) {
        var data = doc.data();
        data['docId'] = doc.id; // Menyertakan docId
        return data;
      }).toList();
    });
  }

  // Fungsi untuk menambahkan FAQ baru
  Future<void> addFaq(String question, String answer) async {
    try {
      await _firestore.collection('faq').add({
        'question': question,
        'answer': answer,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Sukses', 'FAQ berhasil ditambahkan.');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan FAQ: $e');
    }
  }

  // Fungsi untuk mengedit FAQ
  Future<void> editFaq(Map<String, dynamic> faq) async {
    final questionController = TextEditingController(text: faq['question']);
    final answerController = TextEditingController(text: faq['answer']);

    Get.defaultDialog(
      title: 'Edit FAQ',
      content: Column(
        children: [
          TextField(
            controller: questionController,
            decoration: const InputDecoration(labelText: 'Pertanyaan'),
          ),
          TextField(
            controller: answerController,
            decoration: const InputDecoration(labelText: 'Jawaban'),
          ),
        ],
      ),
      textCancel: 'Batal',
      textConfirm: 'Save',
      onConfirm: () async {
        try {
          await _firestore.collection('faq').doc(faq['docId']).update({
            'question': questionController.text,
            'answer': answerController.text,
          });
          Get.snackbar('Sukses', 'FAQ berhasil diperbarui.');
          Get.back();
        } catch (e) {
          Get.snackbar('Error', 'Gagal memperbarui FAQ: $e');
        }
      },
    );
  }

  // Fungsi untuk menghapus FAQ
  Future<void> deleteFaq(String docId) async {
    try {
      await _firestore.collection('faq').doc(docId).delete();
      Get.snackbar('Sukses', 'FAQ berhasil dihapus.');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus FAQ: $e');
    }
  }

  // Method untuk menyimpan produk ke Firestore
  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection('products').add(productData);
      Get.snackbar('Sukses', 'Produk berhasil ditambahkan.');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan produk: $e');
    }
  }

  // Fungsi untuk mengedit produk
  Future<void> editProduct(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('products').doc(docId).update(updatedData);
      Get.snackbar('Sukses', 'Produk berhasil diperbarui.');
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui produk: $e');
    }
  }

  // Fungsi untuk menghapus produk
  Future<void> deleteProduct(String docId) async {
    try {
      await _firestore.collection('products').doc(docId).delete();
      Get.snackbar('Sukses', 'Produk berhasil dihapus.');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus produk: $e');
    }
  }

  // Fungsi untuk menyimpan data keranjang
  Future<void> addToCart(Map<String, dynamic> productData, int quantity) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        Get.snackbar(
          "Error",
          "Anda harus login untuk menambahkan produk ke keranjang",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Save the product data to the "cart" collection in Firebase
      await _firestore.collection('cart').add({
        'uid': user.uid,
        'name': productData['name'] ?? 'Nama tidak tersedia',
        'price': productData['price']?.toString() ?? '0',
        'imageUrl': productData['image_url'] ?? '',
        'size': productData['size']?.toString() ?? 'N/A',
        'quantity': quantity,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show success message
      Get.snackbar(
        "Berhasil",
        "Produk berhasil ditambahkan ke keranjang",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menambahkan produk ke keranjang: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi untuk menghapus data keranjang
  Future<void> deleteCartItem(String cartItemId) async {
  try {
    await _firestore.collection('cart').doc(cartItemId).delete();
    Get.snackbar(
      "Sukses",
      "Produk berhasil dihapus dari keranjang",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghapus produk dari keranjang: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Method untuk mengecek apakah produk ada dalam wishlist
  Future<bool> checkIfInWishlist(String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final wishlistDoc = await _firestore
            .collection('wishlist')
            .where('uid', isEqualTo: user.uid)
            .where('productId', isEqualTo: productId)
            .get();

        return wishlistDoc.docs.isNotEmpty;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengecek status wishlist: $e');
      return false;
    }
  }

  // Method untuk menambah/menghapus produk dari wishlist
  Future<bool> toggleWishlist(Map<String, dynamic> productData, String productId) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        Get.snackbar(
          'Error',
          'Silahkan login terlebih dahulu untuk menambahkan ke wishlist',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      // Cek status wishlist saat ini
      bool isInWishlist = await checkIfInWishlist(productId);

      if (!isInWishlist) {
        // Tambah ke wishlist
        await _firestore.collection('wishlist').add({
          'uid': user.uid,
          'productId': productId,
          'image_url': productData['image_url'],
          'name': productData['name'],
          'price': productData['price'],
          'size': productData['size'],
          'quantity': 1, // Default quantity
          'timestamp': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Sukses',
          'Produk berhasil ditambahkan ke wishlist',
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        // Hapus dari wishlist
        final wishlistDoc = await _firestore
            .collection('wishlist')
            .where('uid', isEqualTo: user.uid)
            .where('productId', isEqualTo: productId)
            .get();

        for (var doc in wishlistDoc.docs) {
          await doc.reference.delete();
        }

        Get.snackbar(
          'Sukses',
          'Produk berhasil dihapus dari wishlist',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}