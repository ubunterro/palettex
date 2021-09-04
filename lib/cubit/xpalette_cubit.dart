import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:palettex/models/processed_image.dart';
import 'package:palettex/persistence/image_file_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util.dart';

part 'xpalette_state.dart';

class XpaletteCubit extends Cubit<XpaletteState> {
  XpaletteCubit() : super(XpaletteInitialState());

  ImageRepo repo = ImageFileRepo();
  bool isInitialized = false;
  bool doShowOnboarding = true;
  late List<ProcessedImage> images;

  // костыль для камеры чтобы не создавать контроллер по нескольку раз
  // из-за кривых инитстейтов из-за неправильной навигации)))
  bool cameraInit = false;

  //get cameraInit => cameraInit;


  List<ProcessedImage> getImages(){
    return images;
  }

  /// Проверяет нужно ли показывать онбординг
  Future<bool> checkDoShowOnboarding() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    doShowOnboarding = (prefs.getBool('onboarding') ?? true);

    return doShowOnboarding;
  }

  /// Закрыть онбординг. Если showForTheLastTime == true
  /// то больше он отображаться пользователю не будет.
  void closeOnboarding(bool showForTheLastTime) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', !showForTheLastTime);

    loadImages();
  }

  /// Вызывается при переходе в InitialState при загрузке приложения, но и при
  /// выходе из камеры, например, поэтому надо чекать, чтобы не грузить
  /// всё по два раза.
  /// Загружает изображения из репозитория
  void loadImages() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('onboarding', true);

    if (!isInitialized) {
      await repo.init();
      isInitialized = true;

      this.images = await repo.loadImages();
    }

    emit(XpaletteLibraryLoadedState());
  }

  /// получить палитру для выбранного изображения и сохранить его
  /// в репозитории и локальном списке кубита
  void _processSelectedImage(ProcessedImage image) async{
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(image.image!);

    image.colors = palette.colors.toList();
    print(await repo.saveImageFile(image));
    String key = await repo.saveImage(image);
    image.key = key;
    images.add(image);

    emit(XpaletteResultState(image: image, showSavedPopup: true));
  }

  /// удаляет изображение отовсюду и возвращает в библиотеку
  void deleteImage(ProcessedImage image) async {
    repo.deleteImage(image);
    images.remove(image);

    emit(XpaletteLibraryLoadedState());
  }

  /// вывести уже обработанное изображение на странице результата
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

  /// получить фото из кастомной камеры
  void processImageFromCustomCamera(XFile photoFile) async{
    emit(XpaletteResultLoadingState());

    ImageProvider image = await Util.xfileToImage(photoFile);
    _processSelectedImage(ProcessedImage(image: image, imageFile: File(photoFile.path)));
  }

  /// открыть кастомную камеру
  void takePhotoCustom() async{
    final cameras = await availableCameras();
    print(cameras);
    //final firstCamera = cameras.first;
    emit(XpaletteCameraActiveState(cameras));
  }
}
