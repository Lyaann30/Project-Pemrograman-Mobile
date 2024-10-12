import 'package:get/get.dart';

import '../controllers/home_hm_controller.dart';

class HomeHmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeHmController>(
      () => HomeHmController(),
    );
  }
}
