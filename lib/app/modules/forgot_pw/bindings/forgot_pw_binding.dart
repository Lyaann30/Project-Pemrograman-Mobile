import 'package:get/get.dart';

import '../controllers/forgot_pw_controller.dart';

class ForgotPwBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPwController>(
      () => ForgotPwController(),
    );
  }
}
