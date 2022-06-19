import 'dart:math';

import 'package:cnj/controllers/jokes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';

class JokesFooter extends GetView<JokesController> {
  const JokesFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JokesController>(
      id: 0, // depends on [topContent] change
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleButton(
            onTap: controller.openInBrowser,
            child: Icon(
              Icons.open_in_browser_rounded,
              size: 35,
              color: controller.topContent == null || controller.isForceDisabled
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
          const SizedBox(width: 50),
          GetBuilder<JokesController>(
            id: 1, // depends on [liked] and [topContent with id:0] change
            builder: (controller) {
              double turns = 0;
              Color color = Colors.black;

              // assert liked implies topContent exist
              assert(!controller.liked || controller.topContent != null);
              if (controller.isForceDisabled) {
                color = Colors.grey;
              } else {
                if (controller.liked) {
                  color = Colors.deepOrangeAccent;
                  turns = -0.003 * 2 * pi;
                } else if (controller.topContent == null) {
                  color = Colors.grey;
                }
              }

              return AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 60),
                child: ScaleButton(
                  onTap: controller.like,
                  child: Icon(
                    Icons.thumb_up_rounded,
                    color: color,
                    size: 35,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
