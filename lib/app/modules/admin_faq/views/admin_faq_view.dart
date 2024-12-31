import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

class AdminFaqView extends StatelessWidget {
  const AdminFaqView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance AuthController
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin FAQ'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        // Menampilkan daftar FAQ dalam bentuk ListView
        final faqs = controller.faqList;
        return ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final faq = faqs[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(faq['question']),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(faq['answer']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => controller.editFaq(faq),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.deleteFaq(faq['docId']),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFaqDialog(context, controller),
        child: const Icon(Icons.add, color: Color(0xFF8B4513)),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
    );
  }

  // Dialog untuk menambahkan FAQ baru, menggunakan controller dari AuthController
  void _showAddFaqDialog(BuildContext context, AuthController controller) {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add FAQ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Panggil metode addFaq pada AuthController
                controller.addFaq(
                  questionController.text,
                  answerController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
