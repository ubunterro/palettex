import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:palettex/components/image_card.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/models/processed_image.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Галерея'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<XpaletteCubit, XpaletteState>(
          builder: (context, state) {
            if (state is XpaletteLibraryLoadedState) {
              List<ProcessedImage> images =
                  BlocProvider.of<XpaletteCubit>(context)
                      .getImages()
                      .reversed
                      .toList();
              ///  генерируем на каждый объект изображения по виджету карточки
              List<ImageCard> previews = images.map((image) {
                return ImageCard(
                  image: image.image!,
                  colors: image.colors,
                  onTap: () {
                    BlocProvider.of<XpaletteCubit>(context)
                        .showPreprocessedImage(image);
                  },
                );
              }).toList();

              return Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: previews,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add_a_photo_rounded,
          spacing: 30,
          childrenButtonSize: 80,
          children: [
            SpeedDialChild(
                label: "Фото",
                onTap: () async =>
                    BlocProvider.of<XpaletteCubit>(context).takePhoto(),
                child: Icon(Icons.photo_camera)),
            SpeedDialChild(
                label: "Камера",
                onTap: () async =>
                    BlocProvider.of<XpaletteCubit>(context).takePhotoCustom(),
                child: Icon(Icons.camera)),
            SpeedDialChild(
                label: "Галерея",
                onTap: () async => BlocProvider.of<XpaletteCubit>(context)
                    .selectImageFromGallery(),
                child: Icon(Icons.photo)),
          ],
        ),
      ),
    );
  }
}
