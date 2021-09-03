import 'dart:io';

import 'package:flutter/cupertino.dart';

class ProcessedImage {
  ImageProvider? image;
  final File? imageFile;
  List<Color>? colors ;

  ProcessedImage({this.image, this.imageFile, this.colors});
}