
import 'package:flutter/material.dart';

class BigBoxColored extends StatelessWidget {
  const BigBoxColored({
    Key? key,
    required this.color
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}