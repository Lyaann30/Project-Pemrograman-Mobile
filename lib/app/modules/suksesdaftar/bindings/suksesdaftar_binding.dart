import 'package:get/get.dart';

import '../controllers/suksesdaftar_controller.dart';

class SuksesdaftarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuksesdaftarController>(
      () => SuksesdaftarController(),
    );
  }
}
