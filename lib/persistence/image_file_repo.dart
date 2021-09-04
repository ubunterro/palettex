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
  Future<String> saveImage(ProcessedImage image);
  Future<String> saveImageFile(ProcessedImage image);
  Future<ProcessedImage> loadImage(String path);
  Future<List<ProcessedImage>> loadImages();
  Future<void> deleteImage(ProcessedImage image);
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
    ///
    ///
    List<ProcessedImage> images = [];
    _box.toMap().forEach((key, i) {
      images.add(ProcessedImage(
          image: FileImage(File(i.path)),
          imageFile: File(i.path),
          key: key,
          colors: i.palette.map((c) => Color(c)).toList()));
    });

    return images;
  }

  /// Сохраняет данные об изображении в хранилище
  Future<String> saveImage(ProcessedImage image) async{
    if (image.imageFile != null && image.colors!= null) {
      /// в качестве ключа юзаем unix timestamp
      final String key = DateTime.now().millisecondsSinceEpoch.toString();
      List<int> colors = image.colors!.map((e) => e.value).toList();

      StorableProcessedImage toSave = StorableProcessedImage(
          image.imageFile!.path, colors);

      _box.put(key, toSave);
      return key;
    }
    return "";
  }


  /// Cохраняет само изображение (файл), хранящееся в объекте ProcessedImage в ФС
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

  /// создаёт инстанс изображения из файла по его пути
  Future<ProcessedImage> loadImage(String path) async{
    return ProcessedImage(
      image: FileImage(File(path)),
      imageFile: File(path)
    );
  }

  /// Удаляет из хранилища и библиотеки само изображение и файл с ним.
  Future<void> deleteImage(ProcessedImage image) async{
    if (image.imageFile != null) {
      print(image.imageFile!.path);
      image.imageFile!.delete();
      if (image.key != ""){
        _box.delete(image.key);
      }
    }
  }


}
