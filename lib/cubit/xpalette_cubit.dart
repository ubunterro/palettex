import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:palettex/models/processed_image.dart';
import 'package:palettex/persistence/image_file_repo.dart';

import '../util.dart';

part 'xpalette_state.dart';

class XpaletteCubit extends Cubit<XpaletteState> {
  XpaletteCubit() : super(XpaletteInitialState());

  ImageRepo repo = ImageFileRepo();

  void loadImages() async{
    //print('start loading');
    await repo.init();
    List<ProcessedImage> images = await repo.loadImages();

    emit(XpaletteLibraryLoadedState(images: images));
    //print('done loading');
  }

  void _processSelectedImage(ProcessedImage image) async{
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(image.image!);

    image.colors = palette.colors.toList();
    print(await repo.saveImageFile(image));
    repo.saveImage(image);

    emit(XpaletteResultState(image: image));
  }

  void showPreprocessedImage(ProcessedImage image) async{
    emit(XpaletteResultState(image: image));
  }

  /// снять фото камерой
  void takePhoto() async{
    emit(XpaletteResultLoadingState());

    final ImagePicker _picker = ImagePicker();
    final XFile? photoFile = await _picker.pickImage(source: ImageSource.camera);
    if (photoFile == null){
      emit(XpaletteInitialState());
    } else {
      ImageProvider image = await Util.xfileToImage(photoFile);
      _processSelectedImage(ProcessedImage(image: image, imageFile: File(photoFile.path)));
    }
  }


  /// выбрать фото из галереи
  void selectImageFromGallery() async{
    emit(XpaletteResultLoadingState());

    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null){
      emit(XpaletteInitialState());
    } else {
      ImageProvider image = await Util.xfileToImage(imageFile);
      _processSelectedImage(ProcessedImage(image: image, imageFile: File(imageFile.path)));
    }
  }

  void selectImageFromLibrary() async{
    emit(XpaletteResultLoadingState());
  }
}
