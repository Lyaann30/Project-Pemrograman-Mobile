import 'package:get/get.dart';

import '../controllers/brandms1_controller.dart';

class Brandms1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandms1Controller>(
      () => Brandms1Controller(),
    );
  }
}
