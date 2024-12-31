import 'package:get/get.dart';

import '../controllers/brandhm1_controller.dart';

class Brandhm1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandhm1Controller>(
      () => Brandhm1Controller(),
    );
  }
}
