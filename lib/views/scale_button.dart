import 'package:flutter/material.dart';

class ScaleButton extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onTap;
  final Widget child;

  const ScaleButton({
    Key? key,
    this.duration = const Duration(milliseconds: 40),
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
}
