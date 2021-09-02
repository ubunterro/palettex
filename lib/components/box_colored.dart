import 'package:flutter/material.dart';

/// цветной квадратик
class BoxColored extends StatelessWidget {
  const BoxColored({
    required this.color,
  });

  final Color color;
  //final bool isRounded;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
