import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/pages/camera_page.dart';
import 'package:palettex/pages/library_page.dart';
import 'package:palettex/pages/loading_page.dart';
import 'package:palettex/pages/onboarding_page.dart';
import 'package:palettex/pages/result_page.dart';
import 'package:palettex/cubit/xpalette_navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/': (context) => XpaletteNavigator(),
        '/library': (context) => LibraryPage(),
        '/result': (context) => ResultPage(),
        '/loading': (context) => LoadingPage(),
        '/onboarding': (context) => OnboardingPage(),
        '/camera': (context) => CameraPage()
      },
      initialRoute: '/onboarding',
    );
  }
}
