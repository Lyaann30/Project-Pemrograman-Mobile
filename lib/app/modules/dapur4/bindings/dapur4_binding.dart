import 'package:get/get.dart';
import 'package:myapp/app/modules/dapur4/controllers/dapur4_controller.dart';

class Dapur4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dapur4Controller>(
      () => Dapur4Controller(),
    );
  }
}
