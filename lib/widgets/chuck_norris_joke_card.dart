import 'package:flutter/material.dart';

class ChuckNorrisJokeCard extends StatelessWidget {
  final String text;
  const ChuckNorrisJokeCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SizedBox(
        width: 300,
        height: 300 * 1.618,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  "https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png",
                ), // TODO: asset
                Text(
                  "Anthony Weiner resigned from congress and immediately committed suicide after learning that he had also accidently sent a twit to Chuck Norris.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
