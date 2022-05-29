import 'package:flutter/material.dart';
import '../text_card.dart';

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
      }
      else {
        joke = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: joke != null ? TextCard(text: joke!) : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _like,
        tooltip: "like",
        child: const Icon(Icons.favorite)
      ),
    );
  }
}
