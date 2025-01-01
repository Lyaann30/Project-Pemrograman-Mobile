import 'package:get/get.dart';

import '../controllers/interior1_controller.dart';

class Interior1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Interior1Controller>(
      () => Interior1Controller(),
    );
  }
}
