import 'package:cnj/controllers/jokes_page_controller.dart';
import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

import 'card.dart';

class JokesPageBody extends GetView<JokesPageController> {
  const JokesPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwipableStack(
        stackClipBehaviour: Clip.none,
        swipeAnchor: SwipeAnchor.bottom,
        controller: controller.swiper,
        allowVerticalSwipe: false,
        onWillMoveNext: (i, d) {
          bool canSwipe = controller.canSwipe;
          if (canSwipe) {
            controller.reset();
          }
          return canSwipe;
        },
        builder: (context, properties) {
          double opacity = 0;
          Duration duration = const Duration(milliseconds: 0);
          void Function(ChuckNorrisJoke)? onContentUpdated;

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
              child: JokeCard(
                onFutureCompleted: onContentUpdated,
              ),
            ),
          );
        },
      ),
    );
  }
}
