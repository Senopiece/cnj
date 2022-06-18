import 'dart:async';

import 'package:cnj/datatypes/jokes_source.dart';
import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:cnj/views/scale_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Note that this is the only class that uses vanilla
/// state management as it is most suitable this case
class JokeCard<Source extends JokesSource> extends StatefulWidget {
  final void Function(ChuckNorrisJoke)? onFutureCompleted;

  const JokeCard({
    Key? key,
    this.onFutureCompleted,
  }) : super(key: key);

  @override
  State<JokeCard> createState() => _JokeCardState<Source>();
}

class _JokeCardState<Source extends JokesSource> extends State<JokeCard> {
  final source = Get.find<Source>();
  late Future<ChuckNorrisJoke> future;
  ChuckNorrisJoke? result;
  bool said = false;

  @override
  Widget build(BuildContext context) {
    // TODO: when it comes first place, try to refresh content
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
            child: Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<ChuckNorrisJoke?> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'oops!\n While fetching this joke some problem has occurred',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    );
                  }

                  ChuckNorrisJoke joke = snapshot.data!;
                  String categories = joke.categories.isEmpty
                      ? 'no categories'
                      : joke.categories.join(', ');

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        '[ $categories ]',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: Center(
                          child: Text(
                            joke.value,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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
      result = await source.getNextJoke();
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
