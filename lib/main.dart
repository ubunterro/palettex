import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/components/image_card.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/pages/library_page.dart';
import 'package:palettex/pages/loading_page.dart';
import 'package:palettex/pages/result_page.dart';
import 'package:palettex/pages/splash_page.dart';

import 'components/box_colored.dart';

void main() {
  runApp(BlocProvider(create: (context) => XpaletteCubit(), child: PaletteApp(),));
}

class PaletteApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaletteX',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => SplashPage(),
        '/library': (context) => LibraryPage(),
        '/result': (context) => ResultPage(),
        '/loading': (context) => LoadingPage()
      },
      initialRoute: '/library',
      // home: BlocBuilder<XpaletteCubit, XpaletteState>(
      //   builder: (_, state){
      //     if (state is XpaletteInitialState){
      //       return LibraryPage();
      //     } else if (state is XpaletteResultState) {
      //       return ResultPage();
      //     } else {
      //       return LoadingPage();
      //     }
      //   },
      // ),
    );
  }
}
