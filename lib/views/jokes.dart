import 'package:cnj/datatypes/jokes_source.dart';
import 'package:flutter/material.dart';

import 'jokes/body.dart';
import 'jokes/footer.dart';

class Jokes<Source extends JokesSource> extends StatelessWidget {
  const Jokes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
