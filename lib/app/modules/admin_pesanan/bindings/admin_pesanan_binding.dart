import 'package:get/get.dart';

import '../controllers/admin_pesanan_controller.dart';

class AdminPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPesananController>(
      () => AdminPesananController(),
    );
  }
}
