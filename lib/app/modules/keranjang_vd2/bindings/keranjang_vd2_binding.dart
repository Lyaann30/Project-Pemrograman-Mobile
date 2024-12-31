import 'package:get/get.dart';

import '../controllers/keranjang_vd2_controller.dart';

class KeranjangVd2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangVd2Controller>(
      () => KeranjangVd2Controller(),
    );
  }
}
