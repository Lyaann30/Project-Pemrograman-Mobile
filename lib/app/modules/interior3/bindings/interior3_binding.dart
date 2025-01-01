import 'package:get/get.dart';

import '../controllers/interior3_controller.dart';

class Interior3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Interior3Controller>(
      () => Interior3Controller(),
    );
  }
}
