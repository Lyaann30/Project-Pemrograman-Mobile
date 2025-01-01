import 'package:get/get.dart';
import 'package:myapp/app/modules/DAPURHOME/controllers/dapurhome_controller.dart';


class DapurhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DapurhomeController>(
      () => DapurhomeController(),
    );
  }
}
