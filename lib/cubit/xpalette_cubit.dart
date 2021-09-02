import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

import '../util.dart';

part 'xpalette_state.dart';

class XpaletteCubit extends Cubit<XpaletteState> {
  XpaletteCubit() : super(XpaletteInitialState());

  void processSelectedImage(ImageProvider image) async{
    //emit(XpaletteResult(AssetImage('images/il.jpg')));
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(image);

    emit(XpaletteResultState(image: image, palette: palette));
  }

  void takePhoto() async{
    emit(XpaletteResultLoadingState());
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null){
      emit(XpaletteInitialState());
    } else {
      ImageProvider _image = await Util.xfileToImage(photo);
      processSelectedImage(_image);
    }

  }
}
