import 'package:get/get.dart';
import 'package:myapp/app/modules/dapur2/controllers/dapur2_controller.dart';

class Dapur2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dapur3Controller>(
      () => Dapur3Controller(),
    );
  }
}
