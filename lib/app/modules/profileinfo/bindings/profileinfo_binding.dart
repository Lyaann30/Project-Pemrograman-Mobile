import 'package:get/get.dart';
import 'package:myapp/app/modules/profileinfo/controllers/profileinfo_controller.dart';


class ProfileinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileinfoController>(
      () => ProfileinfoController(),
    );
  }
}
