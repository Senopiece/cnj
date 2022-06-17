import 'dart:async';

import 'package:cnj/services/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Architectural assumption: only root can open dialog, so it is
/// Important: do not use Get.dialog/Get.defaultDialog/etc outside this file
class RootController extends GetxController {
  final networkInfo = Get.find<NetworkInfo>();
  late final StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    super.onInit();
    // TODO: test it on the real device
    // TODO: check does it work on start
    subscription = networkInfo.onConnectivityChanged.listen(
      (event) {
        bool isDialogOpen = Get.isDialogOpen ?? false;
        if (event == ConnectivityResult.none) {
          assert(!isDialogOpen);
          Get.defaultDialog(
            middleText: 'Connection lost',
            onWillPop: () async => false,
          );
        } else if (isDialogOpen) {
          Get.back();
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
