import 'package:cnj/controllers/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationRoot extends GetView<RootController> {
  final Widget? child;

  const ApplicationRoot({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child == null
          ? null
          : SafeArea(
              child: child!,
            ),
    );
  }
}
