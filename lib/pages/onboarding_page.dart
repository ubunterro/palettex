import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/pages/loading_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BlocProvider.of<XpaletteCubit>(context).checkDoShowOnboarding(),
        builder: (context, AsyncSnapshot<bool> doShowOnboarding) {
          if (doShowOnboarding.hasData) {
            if (doShowOnboarding.data == true) {
              return IntroductionScreen(
                showNextButton: true,
                next: Icon(Icons.navigate_next),
                pages: [
                  PageViewModel(
                    title: "PaletteX",
                    body:
                    "Простое приложение для получения цветовой палитры изображения",
                    image: Center(
                      child: Image.asset('images/palette.png', height: 175.0),
                    ),
                  ),

                  PageViewModel(
                    title: "Просто сделайте снимок",
                    body:
                    "Нажмите на иконку камеры, чтобы сделать снимок или выбрать изображение из галереи",
                    image: Center(
                      child: Image.asset('images/camera.png', height: 175.0),
                    ),
                  ),

                  PageViewModel(
                    title: "Выберите цвета",
                    body:
                    "Нажмите на выбранный цвет в палитре, чтобы скопировать его hex-код",
                    image: Center(
                      child: Image.asset('images/paint.png', height: 175.0),
                    ),
                  ),

                  PageViewModel(
                    title: "Галерея",
                    body:
                    "Все изображения сохраняются в галерее приложения, так что к палитрам всегда можно вернуться",
                    image: Center(
                      child: Image.asset('images/gallery.png', height: 175.0),
                    ),
                    footer: OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<XpaletteCubit>(context)
                            .closeOnboarding(true);
                      },
                      child: const Text("Больше не показывать"),
                    ),
                  )
                ],
                done: const Text("Далее",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                onDone: () {
                  BlocProvider.of<XpaletteCubit>(context)
                      .closeOnboarding(false);
                },
              );
            } else {
              BlocProvider.of<XpaletteCubit>(context)
                  .closeOnboarding(doShowOnboarding.data!);
              return LoadingPage();
            }
          } else {
            return LoadingPage();
          }
        });
  }
}
