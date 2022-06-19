import 'dart:async';

import 'package:cnj/services/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final networkInfo = Get.find<NetworkInfo>();
  late final StreamSubscription<ConnectivityResult> networkSubscription;

  bool isNoConnectionDialogOpen = false;

  void _handleConnectionChange(ConnectivityResult event) {
    bool isDialogOpen = Get.isDialogOpen ?? false;
    if (event == ConnectivityResult.none) {
      if (isDialogOpen) {
        Get.back(); // replace any dialog
      }
      Get.defaultDialog(
        // fully blocking popup
        middleText: 'No connection',
        onWillPop: () async => false,
      );
      isNoConnectionDialogOpen = true;
    } else if (isNoConnectionDialogOpen) {
      Get.back();
      isNoConnectionDialogOpen = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _handleConnectionChange(await networkInfo.connectivityResult);
    networkSubscription =
        networkInfo.onConnectivityChanged.listen(_handleConnectionChange);
  }

  @override
  void dispose() {
    networkSubscription.cancel();
    super.dispose();
  }
}
