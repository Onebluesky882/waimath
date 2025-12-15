import 'package:flutter/material.dart';

class PaddingXy extends StatelessWidget {
  final double x;
  final double y;
  final Padding? padding;
  final Widget child;

  const PaddingXy({
    super.key,
    this.x = 0,
    this.y = 0,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: x, right: x, top: y, bottom: y),
      child: child,
    );
  }
}
