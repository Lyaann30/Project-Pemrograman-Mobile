import 'package:get/get.dart';
import 'package:myapp/app/modules/dapur1/controllers/dapur1_controller.dart';


class Dapur1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dapur1Controller>(
      () => Dapur1Controller(),
    );
  }
}
