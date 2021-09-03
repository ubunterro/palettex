import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palettex/components/image_card.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/util.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Library'),
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<XpaletteCubit, XpaletteState>(
            builder: (context, state) {
              if (state is XpaletteLibraryLoadedState) {
                //print('interestin');
                print(state.images.length);
                //  генерируем на каждый объект изображения по виджету карточки
                List<ImageCard> previews =
                    state.images.map((image) {
                      return ImageCard(
                          image: image.image!,
                          colors: image.colors,
                          onTap: () {
                            BlocProvider.of<XpaletteCubit>(context).showPreprocessedImage(image);
                          },);
                    }).toList();
                print(previews.length);

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
                  label: "Галерея",
                  onTap: () async =>
                      BlocProvider.of<XpaletteCubit>(context).selectImageFromGallery(),
                  child: Icon(Icons.photo)),
            ],
          )

          /*FloatingActionButton(
          onPressed: () async {
            BlocProvider.of<XpaletteCubit>(context).takePhoto();
          },
          tooltip: 'Add an image',
          child: Icon(Icons.add_a_photo_rounded),
        ),*/ // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
