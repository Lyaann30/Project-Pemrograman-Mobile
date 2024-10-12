import 'package:get/get.dart';

import '../controllers/brandvindys2_controller.dart';

class Brandvindys2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandvindys2Controller>(
      () => Brandvindys2Controller(),
    );
  }
}
