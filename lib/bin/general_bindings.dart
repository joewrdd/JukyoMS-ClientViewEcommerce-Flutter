import 'package:get/get.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/views/shop/controllers/products/variation_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
