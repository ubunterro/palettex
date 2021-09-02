import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

import '../util.dart';

part 'xpalette_state.dart';

class XpaletteCubit extends Cubit<XpaletteState> {
  XpaletteCubit() : super(XpaletteInitialState());


  void loadImages(){
    print('start loading');
    emit(XpaletteLibraryLoadedState(images: [AssetImage('images/il.jpg'), AssetImage('images/il.jpg')]));
    //emit(XpaletteResultLoadingState());
    print('done loading');
}

  void processSelectedImage(ImageProvider image) async{
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(image);

    emit(XpaletteResultState(image: image, palette: palette));
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
      processSelectedImage(image);
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
      processSelectedImage(image);
    }
  }

  void selectImageFromLibrary() async{
    emit(XpaletteResultLoadingState());
  }
}
