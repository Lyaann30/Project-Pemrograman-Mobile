import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

class UserFaqView extends StatelessWidget {
  const UserFaqView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil instance dari AuthController
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
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
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
