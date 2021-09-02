import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palettex/components/image_card.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/util.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ImageCard(),
              ImageCard(),
              ImageCard(),
              ImageCard(),
              ImageCard(),
              ImageCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BlocProvider.of<XpaletteCubit>(context).takePhoto();

          //BlocProvider.of<XpaletteCubit>(context).processSelectedImage(_image);

        },
        tooltip: 'Add an image',
        child: Icon(Icons.add_a_photo_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
