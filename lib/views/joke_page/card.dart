import 'dart:async';

import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:cnj/services/chucknorris.dart';
import 'package:cnj/views/scale_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JokeCard extends StatefulWidget {
  final void Function(ChuckNorrisJoke)? onFutureCompleted;

  const JokeCard({
    Key? key,
    this.onFutureCompleted,
  }) : super(key: key);

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  final chucknorris = Get.find<ChuckNorrisAPI>();
  late Future<ChuckNorrisJoke> future;
  ChuckNorrisJoke? result;
  bool said = false;

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
                const Image(image: AssetImage('images/card_logo.png')),
                FutureBuilder(
                  future: future,
                  builder: (context, AsyncSnapshot<ChuckNorrisJoke?> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    if (snapshot.hasError) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'oops!\n While fetching this joke some problem has occurred',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ScaleButton(
                              onTap: () {
                                // we need to simultaneously initiate a new future
                                // and rebuild this view
                                setState(() {
                                  fetchContent();
                                });
                              },
                              child: Icon(
                                Icons.refresh,
                                size: 60,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Text(
                      snapshot.data!.value,
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

  @override
  void didUpdateWidget(JokeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // so no matter how many widgets you update,
    // only one callback would be invoked
    // Note that here are two types of how it can be invoked:
    // - only the most first callback would be invoked if it was setup after
    //   the future completes, all the others would be ignored
    // - only the latest callback would be invoked if it was setup before
    //   the future completes, all the others would be ignored
    if (result != null) {
      if (widget.onFutureCompleted != null && !said) {
        Future(() async {
          // schedule to say only after the building is completed
          widget.onFutureCompleted!(result!);
        });
        said = true;
      }
    }
  }

  void fetchContent() {
    future = Future(() async {
      result = await chucknorris.fetchRandomJoke();
      assert(said == false);
      if (widget.onFutureCompleted != null) {
        Future(() async {
          // schedule into another future to isolate if it fails
          widget.onFutureCompleted!(result!);
        });
        said = true;
      }
      return result!;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchContent();
  }
}
