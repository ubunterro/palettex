import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XpaletteCubit, XpaletteState>(
      /// наверное это лютый костыль, который надо потом переделать, но вот
      /// какой прикол: при запуске приложения необходимо было как-то его
      /// инициализировать, а так как BlocListener срабатывает только при
      /// изменении состоянии, а не при его инициализации, то для чекания
      /// инициализации используется билдер, хоть это и не очень хорошо,
      /// навнерное, но так оно хоть работает.
      builder: (context, state){
        if (state is XpaletteInitialState){
          print('initial state');
          //Navigator.of(context).pushNamed('/library');
          BlocProvider.of<XpaletteCubit>(context).loadImages();
        }
        return Container(child: Text('1'));
      },
      listener: (context, state){
        print(state.runtimeType);
        if (state is XpaletteLibraryLoadedState){
          print('going to lib');
          Navigator.of(context).pushNamed('/library');
        }
        else if (state is XpaletteResultState) {
          Navigator.of(context).pushReplacementNamed('/result');
        } else {
          Navigator.of(context).pushNamed('/loading');
        }

      },
    );
  }
}
