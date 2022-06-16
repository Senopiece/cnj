import 'package:flutter/material.dart';

import 'joke_page/body.dart';
import 'joke_page/footer.dart';

class JokesPageRoot extends StatelessWidget {
  const JokesPageRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              JokesPageBody(),
              JokesPageFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
