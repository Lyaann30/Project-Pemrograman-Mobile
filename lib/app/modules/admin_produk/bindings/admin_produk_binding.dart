import 'package:get/get.dart';

import '../controllers/admin_produk_controller.dart';

class AdminProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminProdukController>(
      () => AdminProdukController(),
    );
  }
}
