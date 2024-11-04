import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';
import 'package:myapp/app/modules/pencarian/views/pencarian_view.dart';
import 'package:myapp/app/modules/keranjang/views/keranjang_view.dart';
import 'package:myapp/app/modules/wishlist/views/wishlist_view.dart';
import 'package:myapp/app/modules/profile/views/profile_view.dart';

class AlamatSayaView extends StatefulWidget {
  const AlamatSayaView({super.key});

  @override
  _AlamatSayaViewState createState() => _AlamatSayaViewState();
}

class _AlamatSayaViewState extends State<AlamatSayaView> {
  final CollectionReference addressesCollection =
      FirebaseFirestore.instance.collection('addresses');

  Future<void> addAddress(String name, String phone, String address) async {
    await addressesCollection.add({
      'name': name,
      'phone': phone,
      'address': address,
      'label': 'Lainnya',
    });
  }

  Future<void> editAddress(
      String docId, String name, String phone, String address) async {
    await addressesCollection.doc(docId).update({
      'name': name,
      'phone': phone,
      'address': address,
    });
  }

  Future<void> deleteAddress(String docId) async {
    await addressesCollection.doc(docId).delete();
  }

  void showAddressDialog({String? docId, Map<String, dynamic>? data}) {
    final nameController = TextEditingController(text: data?['name'] ?? '');
    final phoneController = TextEditingController(text: data?['phone'] ?? '');
    final addressController = TextEditingController(text: data?['address'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(docId == null ? 'Tambah Alamat' : 'Edit Alamat'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'No. Telepon'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                maxLines: null, // memungkinkan alamat panjang
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
            child: const Text("Batal", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              if (docId == null) {
                addAddress(nameController.text, phoneController.text,
                    addressController.text);
              } else {
                editAddress(docId, nameController.text, phoneController.text,
                    addressController.text);
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4513)),
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Saya', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: addressesCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data['name']} | ${data['phone']}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      const SizedBox(height: 4),
                      Text(data['address'],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B4513),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(data['label'] ?? 'Lainnya',
                                style: const TextStyle(color: Colors.white)),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () =>
                                showAddressDialog(docId: docId, data: data),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Color(0xFF8B4513)),
                            onPressed: () => deleteAddress(docId),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8B4513),
        onPressed: () => showAddressDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        backgroundColor: const Color(0xFF8B4513),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(AllbrandView());
              break;
            case 1:
              Get.to(PencarianView());
              break;
            case 2:
              Get.to(KeranjangView());
              break;
            case 3:
              Get.to(WishlistView());
              break;
            case 4:
              Get.to(ProfileView());
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
