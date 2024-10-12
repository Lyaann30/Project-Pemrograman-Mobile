import 'package:get/get.dart';

import '../controllers/keranjang_hm2_controller.dart';

class KeranjangHm2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangHm2Controller>(
      () => KeranjangHm2Controller(),
    );
  }
}
