import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'chucknorris.dart';
import 'network_info.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChuckNorrisAPI());
    Get.put(NetworkInfo(Connectivity()));
  }
}
