import 'package:get/get.dart';

import '../controllers/admin_faq_controller.dart';

class AdminFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFaqController>(
      () => AdminFaqController(),
    );
  }
}
