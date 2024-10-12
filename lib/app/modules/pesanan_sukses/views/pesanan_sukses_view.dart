import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/allbrand/views/allbrand_view.dart';

import '../controllers/pesanan_sukses_controller.dart';

class PesananSuksesView extends GetView<PesananSuksesController> {
  const PesananSuksesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _checkoutSteps(),
            const SizedBox(height: 40),
            _successIcon(),
            const SizedBox(height: 32),
            const Text(
              'Pesanan Sukses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Terima kasih telah membeli. Pesanan Anda\nakan dikirim dalam 3-5 hari kerja',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            _kembaliBelanjaButton(context),
          ],
        ),
      ),
    );
  }

  Widget _checkoutSteps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: Color(0xFF8B4513)),
        const SizedBox(width: 8),
        _stepIndicator(isActive: true),
        const SizedBox(width: 8),
        _stepIndicator(isActive: true),
        const SizedBox(width: 8),
        const Icon(Icons.credit_card, color: Color(0xFF8B4513)),
        const SizedBox(width: 8),
        _stepIndicator(isActive: true),
        const SizedBox(width: 8),
        const Icon(Icons.check_circle, color: Color(0xFF8B4513)),
      ],
    );
  }

  Widget _stepIndicator({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFF8B4513) : Colors.grey,
      ),
    );
  }

  Widget _successIcon() {
    return Icon(
      Icons.shopping_cart_checkout,
      color: Color(0xFF8B4513),
      size: 120,
    );
  }

  Widget _kembaliBelanjaButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(AllbrandView());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF8B4513),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Center(
        child: Text(
          'Kembali Belanja',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
