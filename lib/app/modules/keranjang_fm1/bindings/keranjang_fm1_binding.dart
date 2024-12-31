import 'package:get/get.dart';

import '../controllers/keranjang_fm1_controller.dart';

class KeranjangFm1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangFm1Controller>(
      () => KeranjangFm1Controller(),
    );
  }
}
