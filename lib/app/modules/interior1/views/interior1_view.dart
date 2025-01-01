import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/interiorkesukses/views/interiorkesukses_view.dart';

class Interior1View extends StatefulWidget {
  const Interior1View({Key? key}) : super(key: key);

  @override
  State<Interior1View> createState() => _Interior1ViewState();
}

class _Interior1ViewState extends State<Interior1View> {
  // Enam controller: 3 untuk Kursi, 3 untuk Meja
  final TextEditingController kursi1 = TextEditingController();
  final TextEditingController kursi2 = TextEditingController();
  final TextEditingController kursi3 = TextEditingController();
  final TextEditingController meja1 = TextEditingController();
  final TextEditingController meja2 = TextEditingController();
  final TextEditingController meja3 = TextEditingController();

  bool _isButtonEnabled = false; // Default: tombol tidak bisa ditekan

  @override
  void initState() {
    super.initState();
    // Tambahkan listener pada setiap controller
    kursi1.addListener(_checkFields);
    kursi2.addListener(_checkFields);
    kursi3.addListener(_checkFields);
    meja1.addListener(_checkFields);
    meja2.addListener(_checkFields);
    meja3.addListener(_checkFields);
  }

  @override
  void dispose() {
    // Jangan lupa dispose agar tidak bocor memori
    kursi1.dispose();
    kursi2.dispose();
    kursi3.dispose();
    meja1.dispose();
    meja2.dispose();
    meja3.dispose();
    super.dispose();
  }

  // Fungsi untuk cek apakah semua field terisi
  void _checkFields() {
    setState(() {
      _isButtonEnabled = 
          kursi1.text.isNotEmpty &&
          kursi2.text.isNotEmpty &&
          kursi3.text.isNotEmpty &&
          meja1.text.isNotEmpty &&
          meja2.text.isNotEmpty &&
          meja3.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF562B08)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Spanyol',
          style: TextStyle(
            color: Color(0xFF562B08),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/LOGO_YUMANSA.png', 
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( 
        child: Container(
          color: const Color(0xFFFFFFF0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar utama
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/interior1.png',
                  height: 180.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ruang tamu yang menghadirkan kesan santai dan modern dengan pendekatan minimalis. Sofa putih lembut dipadukan dengan bantal dekorasi berwarna teal memberikan sentuhan segar. Meja kayu rustic dan karpet berbulu tebal menciptakan suasana hangat dan nyaman, ideal untuk relaksasi atau berkumpul bersama keluarga.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Color(0xFF562B08),
                thickness: 1,
              ),
              
              // Teks Kursi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Kursi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF562B08),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Baris input untuk Kursi: (cm x cm x cm)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildSizeInput(kursi1)),
                    const SizedBox(width: 8),
                    const Text('X',
                        style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSizeInput(kursi2)),
                    const SizedBox(width: 8),
                    const Text('X',
                        style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSizeInput(kursi3)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Teks Meja
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Meja',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF562B08),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Baris input untuk Meja: (cm x cm x cm)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildSizeInput(meja1)),
                    const SizedBox(width: 8),
                    const Text('X',
                        style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSizeInput(meja2)),
                    const SizedBox(width: 8),
                    const Text('X',
                        style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSizeInput(meja3)),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              // Tombol Order Now
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled 
                        ? () => Get.to(() => InteriorSuksesView())
                        : null,  // Jika false, tombol disabled
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF562B08),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Menerima controller agar setiap field terhubung ke state
  Widget _buildSizeInput(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'cm',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
