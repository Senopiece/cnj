import 'dart:async';

import 'package:cnj/datatypes/jokes_source.dart';
import 'package:cnj/models/chuck_norris_joke.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_button/scale_button.dart';

/// Note that this is the only class that uses vanilla
/// state management as it is most suitable this case
class JokeCard<Source extends JokesSource> extends StatefulWidget {
  final void Function(ChuckNorrisJoke?)? futureStatus;
  final bool autoRetry;

  const JokeCard({
    Key? key,
    this.autoRetry = true,
    this.futureStatus,
  }) : super(key: key);

  @override
  State<JokeCard> createState() => _JokeCardState<Source>();
}

class _JokeCardState<Source extends JokesSource> extends State<JokeCard> {
  final source = Get.find<Source>();
  late final StreamSubscription<void> _updates;
  Future<ChuckNorrisJoke>? future;
  int futureId = 0;
  ChuckNorrisJoke? _result;

  set result(ChuckNorrisJoke? val) {
    _result = val;
    Future(() async {
      // schedule into another future to isolate if it fails
      if (widget.futureStatus != null) {
        widget.futureStatus!(_result);
      }
    });
  }

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
            child: FutureBuilder(
              future:
                  future!, // it is important to do set state after each fetchContent(), because we need to update this future
              builder: (context, AsyncSnapshot<ChuckNorrisJoke?> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'oops!\n While fetching this joke some problem has occurred',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
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
    );
  }

  @override
  void didUpdateWidget(JokeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    result = _result;
  }

  @override
  void dispose() {
    futureId++;
    _updates.cancel();
    super.dispose();
  }

  /// Important: do not forget to whap it with setState if you call it
  /// not from initState or didChangeDependencies methods
  void fetchContent() {
    result = null;
    futureId++;
    future = Future(() async {
      // fid is a unique identifier that tells that we listen to this future if
      // fid == futureId, otherwise it means that the future was cancelled,
      // and there is no matter what to return, but we need to return as
      // fast as it can be
      // (dart has no future.cancel() logic, so there is a crunch)
      int fid = futureId;
      ChuckNorrisJoke? fetched;
      while (fid == futureId) {
        if (fetched != null) {
          result = fetched;
          return fetched;
        }

        try {
          fetched = await source.getNextJoke();
        } catch (e) {
          if (!widget.autoRetry && fid == futureId) {
            // do not throw error if it's cancelled
            rethrow;
          }
          assert(fetched == null);
        }
      }

      // as it does not matter in this case what to return,
      // we just need to return something
      return const ChuckNorrisJoke(
        categories: [],
        iconUrl: '',
        id: '',
        url: '',
        value: '',
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetchContent();

    _updates = source.updateStream.listen((event) {
      // set state to update to the new future in the FutureBuilder
      setState(() {
        fetchContent();
      });
    });
  }
}
