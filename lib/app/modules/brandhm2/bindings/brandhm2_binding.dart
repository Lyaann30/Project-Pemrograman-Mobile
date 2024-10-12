import 'package:get/get.dart';

import '../controllers/brandhm2_controller.dart';

class Brandhm2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandhm2Controller>(
      () => Brandhm2Controller(),
    );
  }
}
