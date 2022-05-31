import 'package:flutter/material.dart';

class ImageTextCard extends StatelessWidget {
  final ImageProvider image;
  final String? text;

  const ImageTextCard({
    Key? key,
    required this.image,
    this.text,
  }) : super(key: key);

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
                Image(image: image),
                text == null
                    ? const CircularProgressIndicator()
                    : Text(
                        text!,
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
