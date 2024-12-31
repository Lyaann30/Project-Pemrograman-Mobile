import 'package:get/get.dart';

import '../controllers/brandms2_controller.dart';

class Brandms2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandms2Controller>(
      () => Brandms2Controller(),
    );
  }
}
