import 'package:get/get.dart';

import '../controllers/brandfm1_controller.dart';

class Brandfm1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandfm1Controller>(
      () => Brandfm1Controller(),
    );
  }
}
