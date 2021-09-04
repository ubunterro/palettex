import 'dart:io';
import 'package:flutter/material.dart';

/// изображение, которое может содержать в себе палитру
class ProcessedImage {
  ImageProvider? image;
  final File? imageFile;
  List<Color>? colors;
  late String? key; //ключ в хранилище

  ProcessedImage({this.image, this.imageFile, this.colors, this.key});
}