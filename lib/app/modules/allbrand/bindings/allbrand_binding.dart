import 'package:get/get.dart';

import '../controllers/allbrand_controller.dart';

class AllbrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllbrandController>(
      () => AllbrandController(),
    );
  }
}
