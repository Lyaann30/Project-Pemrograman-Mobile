import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pesanan_sukses/views/pesanan_sukses_view.dart';
import '../controllers/pembayaran_controller.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({super.key});

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
      body: SingleChildScrollView(
        // Membuat halaman bisa di-scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _checkoutSteps(),
            const SizedBox(height: 24),
            _paymentOptions(),
            const SizedBox(height: 24),
            _paymentSummary(),
            const SizedBox(height: 16),
            _pesanButton(context),
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
        _stepIndicator(isActive: false),
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

  Widget _paymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Option',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _bankOption('Transfer Bank'),
              _bankOptionWithImage('Bank BRI', 'assets/LOGO BRI.png'),
              _bankOptionWithImage('Bank BCA', 'assets/LOGO BCA.png'),
              _bankOptionWithImage('Bank BNI', 'assets/LOGO BNI.png'),
              _bankOptionWithImage('Bank Mandiri', 'assets/LOGO MANDIRI.png'),
              _bankOptionWithImage('Bank Syariah Indonesia', 'assets/LOGO BSI.png'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset('assets/LOGO SHOPEEPAY.png', height: 40, width: 40),
              const SizedBox(width: 16),
              const Text('Shopee Pay'),
              const Spacer(),
              const Text(
                '(Saldo Rp800)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bankOption(String bankName) {
    return Row(
      children: [
        Radio(
          value: bankName,
          groupValue: 'bank',
          onChanged: (value) {
            // Aksi saat bank dipilih
          },
        ),
        Text(bankName),
      ],
    );
  }

  Widget _bankOptionWithImage(String bankName, String assetPath) {
    return Row(
      children: [
        Radio(
          value: bankName,
          groupValue: 'bank',
          onChanged: (value) {
            // Aksi saat bank dipilih
          },
        ),
        Image.asset(assetPath, height: 40, width: 40),
        const SizedBox(width: 16),
        Text(bankName),
      ],
    );
  }

  Widget _paymentSummary() {
    return Column(
      children: [
        _summaryRow('Sub-total', 'Rp. 132.000'),
        const SizedBox(height: 8),
        _summaryRow('Biaya Pengiriman', 'Rp. 12.000'),
        const Divider(),
        _summaryRow(
          'Total Pembayaran',
          'Rp. 132.000',
          isBold: true,
        ),
      ],
    );
  }

  Widget _summaryRow(String title, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 16,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 16,
          ),
        ),
      ],
    );
  }

  Widget _pesanButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(PesananSuksesView());
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
          'Pesan',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
