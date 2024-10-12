import 'package:get/get.dart';

import '../controllers/brandfm2_controller.dart';

class Brandfm2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandfm2Controller>(
      () => Brandfm2Controller(),
    );
  }
}
