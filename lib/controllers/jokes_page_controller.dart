import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: handle error on chuchnorris API future completes with a error
// TODO: handle missing network error

class JokesPageController extends GetxController {
  late final SwipableStackController swiper;
  bool liked = false;
  bool likeSwipeDirection = false;
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
          reset();
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

  void reset() {
    liked = false;
    topContent = null;
    update([0]);
  }

  void updateTopContent(ChuckNorrisJoke newTopContent) {
    topContent = newTopContent;
    update([0]);
  }
}
