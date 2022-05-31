import 'package:flutter/material.dart';

class ScaleButton extends StatefulWidget {
  const ScaleButton({
    Key? key,
    this.duration = const Duration(milliseconds: 40),
    this.onTap,
    required this.child,
  }) : super(key: key);

  /// Adjust the animation speed
  ///
  /// Defaults to [300]
  final Duration duration;

  /// Called when the user taps this part of the material.
  final VoidCallback? onTap;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {
          _scale = 1 - _controller.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.animateTo(
          0.1,
          duration: widget.duration,
          curve: Curves.easeInOutExpo,
        );
      },
      onTapUp: (_) {
        _controller.animateBack(
          0,
          duration: widget.duration,
          curve: Curves.easeInOutExpo,
        );
      },
      onTapCancel: () {
        _controller.animateBack(
          0,
          duration: widget.duration,
          curve: Curves.easeInOutExpo,
        );
      },
      onTap: widget.onTap,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
