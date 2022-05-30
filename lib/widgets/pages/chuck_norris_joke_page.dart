import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:cnj/models/chuck_norris_joke.dart';
import '../image_text_card.dart';
import 'dart:convert';

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
  bool likeSwapDirection = false;
  final Map<int, ChuckNorrisJoke?> _preparedCards = {};
  Uri? _currentDisplayingCardSrc;

  void _listenController() => setState(() {});

  void _like() {
    setState(() {
      likeSwapDirection = !likeSwapDirection;
      _controller.next(
        swipeDirection:
            likeSwapDirection ? SwipeDirection.right : SwipeDirection.left,
      );
    });
  }

  Future<void> _openInBrowser() async {
    await launchUrl(_currentDisplayingCardSrc!);
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

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
                  swipeAnchor: SwipeAnchor.bottom,
                  controller: _controller,
                  allowVerticalSwipe: false,
                  onSwipeCompleted: (index, direction) {
                    setState(() {
                      _preparedCards.remove(index);
                      _currentDisplayingCardSrc = null;
                    });
                  },
                  builder: (context, properties) {
                    if (!_preparedCards.containsKey(properties.index)) {
                      _preparedCards[properties.index] = null;
                      _fetchRandomJoke().then((joke) {
                        setState(() {
                          _preparedCards[properties.index] = joke;
                        });
                      });
                    }

                    if (properties.stackIndex == 0) {
                      _currentDisplayingCardSrc =
                          _preparedCards[properties.index] == null
                              ? null
                              : Uri.parse(
                                  _preparedCards[properties.index]!.url);
                      return AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: ImageTextCard(
                            text: _preparedCards[properties.index]?.value,
                          ),
                        ),
                      );
                    }

                    return AnimatedOpacity(
                      opacity: 0,
                      duration: const Duration(milliseconds: 0),
                      child: Center(
                        child: ImageTextCard(
                          text: _preparedCards[properties.index]?.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  // TODO: like icon + icon animation
                  IconButton(
                    icon: const Icon(Icons.open_in_browser_rounded),
                    iconSize: 33,
                    tooltip: "open in browser",
                    onPressed: _currentDisplayingCardSrc != null
                        ? _openInBrowser
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded),
                    iconSize: 33,
                    tooltip: "like",
                    onPressed: _like,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
