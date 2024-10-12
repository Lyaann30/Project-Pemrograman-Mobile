import 'package:get/get.dart';

import '../controllers/alamat_tagihan_controller.dart';

class AlamatTagihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlamatTagihanController>(
      () => AlamatTagihanController(),
    );
  }
}
