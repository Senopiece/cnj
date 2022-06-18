import 'dart:async';

import 'package:cnj/services/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Architectural assumption: only root can open dialog, so it is
/// Important: do not use Get.dialog/Get.defaultDialog/etc outside this file
class RootController extends GetxController {
  final networkInfo = Get.find<NetworkInfo>();
  late final StreamSubscription<ConnectivityResult> networkSubscription;

  void _handleConnectionChange(ConnectivityResult event) {
    bool isDialogOpen = Get.isDialogOpen ?? false;
    if (event == ConnectivityResult.none) {
      assert(!isDialogOpen);
      Get.defaultDialog(
        // fully blocking popup
        middleText: 'No connection',
        onWillPop: () async => false,
      );
    } else if (isDialogOpen) {
      Get.back();
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
