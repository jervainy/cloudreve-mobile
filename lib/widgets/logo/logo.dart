import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  double size;
  LogoWidget({super.key, this.size = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: size, height: size),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(200, 227, 243, 0.7)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipOval(
                child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover),
              ),
            ),
          ),
        )
      )
    );
  }



}