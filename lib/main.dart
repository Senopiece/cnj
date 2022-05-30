import 'package:flutter/material.dart';
import 'widgets/pages/chuck_norris_joke_page.dart';

// TODO: orginize all imports

void main() {
  runApp(const ChuckNorrisJokeApp());
}

class ChuckNorrisJokeApp extends StatelessWidget {
  const ChuckNorrisJokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chuck Norris jokes!",
      theme: ThemeData(
        highlightColor: Colors.lightBlueAccent,
      ),
      home: const ChuckNorrisJokePage(),
    );
  }
}
