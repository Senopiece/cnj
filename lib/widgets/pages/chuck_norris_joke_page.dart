import 'package:flutter/material.dart';
import '../chuck_norris_joke_card.dart';

class ChuckNorrisJokePage extends StatefulWidget {
  const ChuckNorrisJokePage({Key? key}) : super(key: key);

  @override
  State<ChuckNorrisJokePage> createState() => _ChuckNorrisJokesPageState();
}

class _ChuckNorrisJokesPageState extends State<ChuckNorrisJokePage> {
  String? joke;

  void _like() {
    setState(() {
      if (joke == null) {
        joke = "The quick brown fox jumps over the lazy dog";
      } else {
        joke = null;
      }
    });
  }

  void _openInBrowser() {
    setState(() {
      if (joke == null) {
        joke = "The quick brown fox jumps over the lazy dog";
      } else {
        joke = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Kek Norris'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: joke != null
                      ? ChuckNorrisJokeCard(text: joke!)
                      : const CircularProgressIndicator(),
                ),
              ),
              Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.open_in_browser_rounded),
                    iconSize: 33,
                    tooltip: 'open in browser',
                    onPressed: _openInBrowser,
                    highlightColor: Colors.lightBlueAccent,
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded),
                    iconSize: 33,
                    tooltip: 'like',
                    onPressed: _like,
                    highlightColor: Colors.lightBlueAccent,
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
