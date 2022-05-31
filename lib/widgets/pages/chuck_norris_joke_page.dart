import 'dart:convert';
import 'dart:math';

import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swipable_stack/swipable_stack.dart';
import 'package:url_launcher/url_launcher.dart';

import '../image_text_card.dart';
import '../scale_button.dart';

const _logoUrl =
    "https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png";
final _jokeApiUrl = Uri.parse("https://api.chucknorris.io/jokes/random");

Future<ChuckNorrisJoke> _fetchRandomJoke() async {
  ChuckNorrisJoke joke;

  do {
    final response = await http.get(_jokeApiUrl);
    joke = ChuckNorrisJoke.fromJson(
        jsonDecode(response.body) as Map<String, Object?>);
  } while (joke.value.length > 120);

  return joke;
}

class ChuckNorrisJokePage extends StatefulWidget {
  const ChuckNorrisJokePage({Key? key}) : super(key: key);

  @override
  State<ChuckNorrisJokePage> createState() => _ChuckNorrisJokesPageState();
}

class _ChuckNorrisJokesPageState extends State<ChuckNorrisJokePage> {
  late final SwipableStackController _controller;
  final Map<int, ChuckNorrisJoke?> _preparedCards = {};
  int? _topIndex;
  bool _liked = false;
  bool _likeSwapDirection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SwipableStack(
                  stackClipBehaviour: Clip.none,
                  swipeAnchor: SwipeAnchor.bottom,
                  controller: _controller,
                  allowVerticalSwipe: false,
                  onSwipeCompleted: (index, direction) {
                    _preparedCards.remove(index);
                    Future.delayed(const Duration(milliseconds: 0)).then(
                      (value) {
                        setState(() {
                          _topIndex = _controller.currentIndex;
                          _liked = false;
                        });
                      },
                    );
                  },
                  onWillMoveNext: (index, direction) {
                    if (_preparedCards[index] != null) {
                      setState(() {
                        _topIndex = null;
                      });
                    }
                    return _preparedCards[index] != null;
                  },
                  builder: (context, properties) {
                    if (!_preparedCards.containsKey(properties.index)) {
                      _preparedCards[properties.index] = null;
                      _fetchRandomJoke().then((joke) {
                        setState(() {
                          _preparedCards[properties.index] = joke;
                          _topIndex = _controller.currentIndex;
                        });
                      });
                    }

                    if (properties.stackIndex == 0) {
                      return Center(
                        child: AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(milliseconds: 100),
                          child: ImageTextCard(
                            image: const NetworkImage(_logoUrl),
                            text: _preparedCards[properties.index]?.value,
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: AnimatedOpacity(
                        opacity: 0,
                        duration: const Duration(milliseconds: 0),
                        child: ImageTextCard(
                          image: const NetworkImage(_logoUrl),
                          text: _preparedCards[properties.index]?.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleButton(
                    onTap: _openInBrowser,
                    child: Icon(
                      Icons.open_in_browser_rounded,
                      size: 35,
                      color: _preparedCards[_topIndex] == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 50),
                  _liked
                      ? AnimatedRotation(
                          turns: -0.003 * 2 * pi,
                          duration: const Duration(milliseconds: 50),
                          child: ScaleButton(
                            child: Icon(
                              Icons.thumb_up_rounded,
                              color: _preparedCards[_topIndex] == null
                                  ? Colors.grey
                                  : Colors.deepOrangeAccent,
                              size: 35,
                            ),
                          ),
                        )
                      : AnimatedRotation(
                          turns: 0,
                          duration: const Duration(milliseconds: 60),
                          child: ScaleButton(
                            onTap: () {
                              setState(() {
                                _liked = true;
                                Future.delayed(
                                        const Duration(milliseconds: 400))
                                    .then(
                                  (value) {
                                    _like();
                                  },
                                );
                              });
                            },
                            child: Icon(
                              Icons.thumb_up_rounded,
                              color: _preparedCards[_topIndex] == null
                                  ? Colors.grey
                                  : Colors.black,
                              size: 35,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  void _like() {
    setState(() {
      _likeSwapDirection = !_likeSwapDirection;
      _controller.next(
        swipeDirection:
            _likeSwapDirection ? SwipeDirection.right : SwipeDirection.left,
      );
    });
  }

  Future<void> _openInBrowser() async {
    await launchUrl(Uri.parse(_preparedCards[_topIndex]!.url));
  }
}
