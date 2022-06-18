import 'package:cnj/datatypes/jokes_source.dart';
import 'package:flutter/material.dart';

import 'jokes/body.dart';
import 'jokes/footer.dart';

class Jokes<Source extends JokesSource> extends StatelessWidget {
  const Jokes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          JokesBody<Source>(),
          const JokesFooter(),
        ],
      ),
    );
  }
}
