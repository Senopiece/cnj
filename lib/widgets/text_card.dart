import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String text;
  const TextCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline3
        ),
    );
  }
}