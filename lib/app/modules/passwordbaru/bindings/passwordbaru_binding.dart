import 'package:get/get.dart';

import '../controllers/passwordbaru_controller.dart';

class PasswordbaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordbaruController>(
      () => PasswordbaruController(),
    );
  }
}
