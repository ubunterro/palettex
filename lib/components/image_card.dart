
import 'package:flutter/material.dart';
import 'package:palettex/components/box_colored.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5),),),
        width: 95,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: 'photo',
                  child: Image.asset('images/il.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  BoxColored(color: Color(0xFFAAFF00)),
                  BoxColored(color: Color(0xFF00FF00)),
                  BoxColored(color: Color(0xFF00FFFF)),
                  BoxColored(color: Color(0xFFFFFF00)),
                  BoxColored(color: Color(0xFF00FF00)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
