import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  Widget child;
  Color? color;
  BorderBox({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
      ),
      child: child,
    );
  }


}
