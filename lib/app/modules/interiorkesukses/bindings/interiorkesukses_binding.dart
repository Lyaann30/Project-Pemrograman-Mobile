import 'package:get/get.dart';

import '../controllers/interiorkesukses_controller.dart';

class InteriorkesuksesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InteriorkesuksesController>(
      () => InteriorkesuksesController(),
    );
  }
}
