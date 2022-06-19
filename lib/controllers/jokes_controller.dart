import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:url_launcher/url_launcher.dart';

/// Group 0 - observes [topContent] and [liked] changes
/// Group 1 - observes only [liked] changes
class JokesController extends GetxController {
  late final SwipableStackController swiper;
  bool likeSwipeDirection = false;
  bool liked = false;
  ChuckNorrisJoke? topContent;

  bool get canSwipe => topContent != null && !liked;

  @override
  void dispose() {
    super.dispose();
    swiper.dispose();
  }

  void like() {
    if (topContent != null && !liked) {
      liked = true;
      update([1]);

      Future.delayed(
        const Duration(milliseconds: 400),
      ).then(
        (value) {
          likeSwipeDirection = !likeSwipeDirection;
          swiper.next(
            swipeDirection:
                likeSwipeDirection ? SwipeDirection.right : SwipeDirection.left,
            ignoreOnWillMoveNext: true,
          );
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    swiper = SwipableStackController();
  }

  Future<void> openInBrowser() async {
    if (topContent != null) {
      await launchUrl(Uri.parse(topContent!.url));
    }
  }

  void updateTopContent(ChuckNorrisJoke? newTopContent) {
    if (liked != false || topContent != newTopContent) {
      liked = false;
      topContent = newTopContent;
      update([0]);
    }
  }
}
