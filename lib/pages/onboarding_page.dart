import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';
import 'package:palettex/pages/loading_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BlocProvider.of<XpaletteCubit>(context).checkDoShowOnboarding(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true){
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Text('very cool proggie'),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<XpaletteCubit>(context)
                              .closeOnboarding(false);
                        },
                        child: Text('close'),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<XpaletteCubit>(context)
                              .closeOnboarding(true);
                        },
                        child: Text('больше не показывать...'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              BlocProvider.of<XpaletteCubit>(context).closeOnboarding(snapshot.data!);
              return LoadingPage();
            }
          } else {
            return Container();
          }
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<XpaletteCubit, XpaletteState>(builder: (context, state) {
  //     if (BlocProvider.of<XpaletteCubit>(context).checkDoShowOnboarding()) {
  //       return Scaffold(
  //         body: SafeArea(
  //           child: Column(
  //             children: [
  //               Text('very cool proggie'),
  //               TextButton(
  //                 onPressed: () {
  //                   BlocProvider.of<XpaletteCubit>(context).closeOnboarding(false);
  //                 },
  //                 child: Text('close'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   BlocProvider.of<XpaletteCubit>(context).closeOnboarding(true);
  //                 },
  //                 child: Text('больше не показывать...'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     } else {
  //       BlocProvider.of<XpaletteCubit>(context).closeOnboarding(true);
  //       return LoadingPage();
  //     }
  //   });
  // }
}
