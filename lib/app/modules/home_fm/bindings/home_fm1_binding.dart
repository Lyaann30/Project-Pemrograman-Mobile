import 'package:get/get.dart';

import '../controllers/home_fm1_controller.dart';

class HomeFm1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeFm1Controller>(
      () => HomeFm1Controller(),
    );
  }
}
