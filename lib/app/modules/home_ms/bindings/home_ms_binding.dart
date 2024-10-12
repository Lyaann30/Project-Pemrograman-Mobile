import 'package:get/get.dart';

import '../controllers/home_ms_controller.dart';

class HomeMsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeMsController>(
      () => HomeMsController(),
    );
  }
}
