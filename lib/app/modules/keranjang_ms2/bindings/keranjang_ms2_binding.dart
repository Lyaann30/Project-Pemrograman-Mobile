import 'package:get/get.dart';

import '../controllers/keranjang_ms2_controller.dart';

class KeranjangMs2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangMs2Controller>(
      () => KeranjangMs2Controller(),
    );
  }
}
