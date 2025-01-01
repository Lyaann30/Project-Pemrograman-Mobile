import 'package:get/get.dart';

import '../controllers/interior4_controller.dart';

class Interior4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Interior4Controller>(
      () => Interior4Controller(),
    );
  }
}
