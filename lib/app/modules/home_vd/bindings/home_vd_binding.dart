import 'package:get/get.dart';

import '../controllers/home_vd_controller.dart';

class HomeVdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeVdController>(
      () => HomeVdController(),
    );
  }
}
