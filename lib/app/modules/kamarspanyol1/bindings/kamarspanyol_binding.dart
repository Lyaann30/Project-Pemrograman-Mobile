import 'package:get/get.dart';

import '../controllers/kamarspanyol_controller.dart';

class KamarspanyolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KamarspanyolController>(
      () => KamarspanyolController(),
    );
  }
}
