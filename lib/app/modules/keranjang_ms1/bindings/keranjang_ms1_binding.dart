import 'package:get/get.dart';

import '../controllers/keranjang_ms1_controller.dart';

class KeranjangMs1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangMs1Controller>(
      () => KeranjangMs1Controller(),
    );
  }
}
