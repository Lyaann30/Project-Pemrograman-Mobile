import 'package:get/get.dart';

import '../controllers/kamaramerika1_controller.dart';

class Kamaramerika1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kamaramerika1Controller>(
      () => Kamaramerika1Controller(),
    );
  }
}
