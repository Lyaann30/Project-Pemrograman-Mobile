import 'package:get/get.dart';

import '../controllers/user_faq_controller.dart';

class UserFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserFaqController>(
      () => UserFaqController(),
    );
  }
}
