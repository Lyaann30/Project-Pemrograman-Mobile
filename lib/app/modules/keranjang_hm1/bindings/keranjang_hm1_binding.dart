import 'package:get/get.dart';

import '../controllers/keranjang_hm1_controller.dart';

class KeranjangHm1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangHm1Controller>(
      () => KeranjangHm1Controller(),
    );
  }
}
