import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';

class XpaletteNavigator extends StatelessWidget {
  const XpaletteNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XpaletteCubit, XpaletteState>(
      /// наверное это лютый костыль, который надо потом переделать, но вот
      /// какой прикол: при запуске приложения необходимо было как-то его
      /// инициализировать, а так как BlocListener срабатывает только при
      /// изменении состоянии, а не при его инициализации, то для чекания
      /// инициализации используется билдер, хоть это и не очень хорошо,
      /// навнерное, но так оно хоть работает.
      builder: (context, state) {
        if (state is XpaletteInitialState) {
          BlocProvider.of<XpaletteCubit>(context).checkDoShowOnboarding();
        }
        return Container(child: Text('error'));
      },
      listener: (context, state) {
        print(state.runtimeType);
        if (state is XpaletteLibraryLoadedState) {
          print('going to lib');
          Navigator.of(context).pushNamed('/library');
        } else if (state is XpaletteResultState) {
          Navigator.of(context).pushReplacementNamed('/result');
        } else if (state is XpaletteOnboardingShownState) {
          Navigator.of(context).pushNamed('/onboarding');
        } else if (state is XpaletteCameraActiveState) {
          Navigator.of(context).pushReplacementNamed('/camera');
        } else {
          Navigator.of(context).pushNamed('/loading');
        }
      },
    );
  }
}
