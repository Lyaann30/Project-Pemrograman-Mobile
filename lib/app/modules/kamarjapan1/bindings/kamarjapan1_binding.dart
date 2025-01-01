import 'package:get/get.dart';

import '../controllers/kamarjapan1_controller.dart';

class Kamarjapan1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kamarjapan1Controller>(
      () => Kamarjapan1Controller(),
    );
  }
}
