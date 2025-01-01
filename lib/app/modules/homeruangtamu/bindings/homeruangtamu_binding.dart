import 'package:get/get.dart';

import '../controllers/homeruangtamu_controller.dart';

class HomeruangtamuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeruangtamuController>(
      () => HomeruangtamuController(),
    );
  }
}
