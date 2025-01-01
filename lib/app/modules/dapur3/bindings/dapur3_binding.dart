import 'package:get/get.dart';
import 'package:myapp/app/modules/dapur3/controllers/dapur3_controller.dart';


class Dapur3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dapur3Controller>(
      () => Dapur3Controller(),
    );
  }
}
