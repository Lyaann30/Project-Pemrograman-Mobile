import 'package:get/get.dart';

import '../controllers/interior2_controller.dart';

class Interior2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Interior2Controller>(
      () => Interior2Controller(),
    );
  }
}
