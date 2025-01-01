import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk FilteringTextInputFormatter
import 'package:get/get.dart';
import 'package:myapp/app/modules/interiorkesukses/views/interiorkesukses_view.dart';

class Kamaramerika1View extends StatefulWidget {
  const Kamaramerika1View({Key? key}) : super(key: key);

  @override
  State<Kamaramerika1View> createState() => _Kamaramerika1ViewState();
}

class _Kamaramerika1ViewState extends State<Kamaramerika1View> {
  final TextEditingController kasur1 = TextEditingController();
  final TextEditingController kasur2 = TextEditingController();
  final TextEditingController kasur3 = TextEditingController();

  final TextEditingController kursi1 = TextEditingController();
  final TextEditingController kursi2 = TextEditingController();
  final TextEditingController kursi3 = TextEditingController();

  final TextEditingController lemari1 = TextEditingController();
  final TextEditingController lemari2 = TextEditingController();
  final TextEditingController lemari3 = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    [
      kasur1, kasur2, kasur3,
      kursi1, kursi2, kursi3,
      lemari1, lemari2, lemari3
    ].forEach((ctrl) => ctrl.addListener(_checkFields));
  }

  @override
  void dispose() {
    kasur1.dispose();
    kasur2.dispose();
    kasur3.dispose();
    kursi1.dispose();
    kursi2.dispose();
    kursi3.dispose();
    lemari1.dispose();
    lemari2.dispose();
    lemari3.dispose();
    super.dispose();
  }

  void _checkFields() {
    setState(() {
      _isButtonEnabled = 
          kasur1.text.isNotEmpty &&
          kasur2.text.isNotEmpty &&
          kasur3.text.isNotEmpty &&
          kursi1.text.isNotEmpty &&
          kursi2.text.isNotEmpty &&
          kursi3.text.isNotEmpty &&
          lemari1.text.isNotEmpty &&
          lemari2.text.isNotEmpty &&
          lemari3.text.isNotEmpty;
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Amerika Klasik',
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/kamar2.jpg',
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
                'Kamar bergaya Amerika klasik menggabungkan elemen elegan dan '
                'fungsional dengan furnitur kayu, aksen vintage, dan suasana '
                'hangat yang nyaman dan timeless.',
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

              _buildSection('Kasur', [kasur1, kasur2, kasur3]),
              const SizedBox(height: 16),
              _buildSection('Kursi', [kursi1, kursi2, kursi3]),
              const SizedBox(height: 16),
              _buildSection('Lemari', [lemari1, lemari2, lemari3]),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () => Get.to(() => InteriorSuksesView())
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF562B08),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF562B08),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: _buildSizeInput(controllers[0])),
              const SizedBox(width: 8),
              const Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
              const SizedBox(width: 8),
              Expanded(child: _buildSizeInput(controllers[1])),
              const SizedBox(width: 8),
              const Text('X', style: TextStyle(fontSize: 18, color: Color(0xFF562B08))),
              const SizedBox(width: 8),
              Expanded(child: _buildSizeInput(controllers[2])),
            ],
          ),
        ),
      ],
    );
  }

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
