import 'package:get/get.dart';

import '../controllers/new_pw_controller.dart';

class NewPwBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPwController>(
      () => NewPwController(),
    );
  }
}
