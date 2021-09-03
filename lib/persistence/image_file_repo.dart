import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palettex/models/processed_image.dart';
import 'package:palettex/models/storable_processed_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class ImageRepo{
  ImageRepo();
  Future<void> init();
  Future<void> saveImage(ProcessedImage image);
  Future<String> saveImageFile(ProcessedImage image);
  Future<ProcessedImage> loadImage(String path);
  Future<List<ProcessedImage>> loadImages();
}

class ImageFileRepo extends ImageRepo{

  late Box<StorableProcessedImage> _box;

  Future<void> init() async{

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(StorableProcessedImageAdapter());
    }

    _box = await Hive.openBox('imagesBox');
  }

  Future<List<ProcessedImage>> loadImages() async{
    /// загружаем изображение из хайва
    /// превращаем каждое StorableProcessedImage
    /// в ProcessedImage при помощи map, так же в нём преобразуем
    /// ARGB инты обратно в Color'ы.
    return _box.values.map((i) => ProcessedImage(
      image: FileImage(File(i.path)),
      imageFile: File(i.path),
      colors: i.palette.map((c) => Color(c)).toList()
    )).toList();
  }

  Future<void> saveImage(ProcessedImage image) async{
    if (image.imageFile != null && image.colors!= null) {
      List<int> colors = image.colors!.map((e) => e.value).toList();

      StorableProcessedImage toSave = StorableProcessedImage(
          image.imageFile!.path, colors);
      /// в качестве ключа юзаем unix timestamp
      _box.put(DateTime.now().millisecondsSinceEpoch.toString(), toSave);
    }
  }


  Future<String> saveImageFile(ProcessedImage image) async{
    if (image.imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      // print(basename(image.imageFile!.path));
      // print(image.imageFile!);

      final File newImage = await image.imageFile!.copy(path + '/' + basename(image.imageFile!.path));
      return newImage.path;
    } else {
      print('image is null');
      return "";
    }
  }

  Future<ProcessedImage> loadImage(String path) async{
    return ProcessedImage(
      image: FileImage(File(path)),
      imageFile: File(path)
    );
  }


}
