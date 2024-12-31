import 'package:get/get.dart';

import '../controllers/keranjang_fm2_controller.dart';

class KeranjangFm2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangFm2Controller>(
      () => KeranjangFm2Controller(),
    );
  }
}
