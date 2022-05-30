import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cnj/models/chuck_norris_joke.dart';

final _jokeApiUrl = Uri.parse("https://api.chucknorris.io/jokes/random");

Future<ChuckNorrisJoke> _fetchRandomJoke() async {
  final response = await http.get(_jokeApiUrl);
  return ChuckNorrisJoke.fromJson(
      jsonDecode(response.body) as Map<String, Object?>);
}

class ChuckNorrisJokeCard extends StatelessWidget {
  const ChuckNorrisJokeCard({Key? key}) : super(key: key);

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
                ),
                FutureBuilder<ChuckNorrisJoke>(
                  future: _fetchRandomJoke(),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return const CircularProgressIndicator();
                    }
                    return Text(
                      data.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
