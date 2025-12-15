import 'package:flutter/material.dart';

class PaddingX extends StatelessWidget {
  final double number;
  final Widget child;

  const PaddingX({super.key, required this.number, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: number, right: number),
      child: child,
    );
  }
}


class PaddingY extends StatelessWidget {
  final double number;
  final Widget child;

  const PaddingY({super.key, required this.child, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: number, bottom: number),
      child: child,
    );
  }
}
