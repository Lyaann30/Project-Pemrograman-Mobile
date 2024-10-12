import 'package:get/get.dart';

import '../controllers/pesanan_sukses_controller.dart';

class PesananSuksesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesananSuksesController>(
      () => PesananSuksesController(),
    );
  }
}
