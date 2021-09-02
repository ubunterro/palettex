import 'dart:io';
//import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';




class Util{
  static Future<ImageProvider> xfileToImage(XFile xFile) async{
    final path = xFile.path;
    final bytes = await File(path).readAsBytes();
    return MemoryImage(bytes);
  }
}