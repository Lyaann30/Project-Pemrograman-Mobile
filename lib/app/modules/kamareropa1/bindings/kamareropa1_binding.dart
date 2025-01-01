import 'package:get/get.dart';

import '../controllers/kamareropa1_controller.dart';

class Kamareropa1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kamareropa1Controller>(
      () => Kamareropa1Controller(),
    );
  }
}
