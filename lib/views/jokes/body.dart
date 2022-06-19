import 'package:cnj/controllers/jokes_controller.dart';
import 'package:cnj/datatypes/jokes_source.dart';
import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

import 'card.dart';

class JokesBody<Source extends JokesSource> extends GetView<JokesController> {
  const JokesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwipableStack(
        stackClipBehaviour: Clip.none,
        swipeAnchor: SwipeAnchor.bottom,
        controller: controller.swiper,
        allowVerticalSwipe: false,
        onSwipeCompleted: (i, d) {
          controller.dismissForceDisable();
        },
        onWillMoveNext: (i, d) {
          controller.forceDisable();
          return controller.canSwipe;
        },
        builder: (context, properties) {
          double opacity = 0;
          Duration duration = const Duration(milliseconds: 0);
          void Function(ChuckNorrisJoke?)? onContentUpdated;

          if (properties.stackIndex == 0) {
            opacity = 1;
            duration = const Duration(milliseconds: 100);
            onContentUpdated = controller.updateTopContent;
          }

          return Center(
            key: ValueKey(properties.index),
            child: AnimatedOpacity(
              opacity: opacity,
              duration: duration,
              child: JokeCard<Source>(
                autoRetry: properties.stackIndex != 0,
                futureStatus: onContentUpdated,
              ),
            ),
          );
        },
      ),
    );
  }
}
