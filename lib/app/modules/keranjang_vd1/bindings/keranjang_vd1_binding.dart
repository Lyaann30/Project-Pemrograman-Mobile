import 'package:get/get.dart';

import '../controllers/keranjang_vd1_controller.dart';

class KeranjangVd1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangVd1Controller>(
      () => KeranjangVd1Controller(),
    );
  }
}
