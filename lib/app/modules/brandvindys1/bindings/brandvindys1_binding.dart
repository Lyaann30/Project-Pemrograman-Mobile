import 'package:get/get.dart';

import '../controllers/brandvindys1_controller.dart';

class Brandvindys1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Brandvindys1Controller>(
      () => Brandvindys1Controller(),
    );
  }
}
