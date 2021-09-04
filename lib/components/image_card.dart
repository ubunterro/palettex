import 'package:flutter/material.dart';
import 'package:palettex/components/box_colored.dart';

/// Миниатюра изображения в галерее
class ImageCard extends StatelessWidget {
  final ImageProvider image;
  // цвета для отображения внизу карточки
  final List<Color>? colors;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ImageCard({
    Key? key,
    required this.image,
    required this.colors,
    this.onTap,
    this.onLongPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BoxColored> coloredBoxes;

    if (colors != null){
      if (colors!.length == 0){
         coloredBoxes = [];
      } else {
        coloredBoxes = [
          BoxColored(color: colors![0]),
          BoxColored(color: colors![1]),
          BoxColored(color: colors![2]),
          BoxColored(color: colors![3]),
          BoxColored(color: colors![4]),
        ];
      }
    } else {
      coloredBoxes = [];
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
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
                  child: Image(image: image, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: coloredBoxes,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
