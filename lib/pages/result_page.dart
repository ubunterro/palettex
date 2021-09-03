import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/components/big_box_colored.dart';
import 'package:palettex/components/image_card.dart';
import 'package:palettex/components/box_colored.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<XpaletteCubit, XpaletteState>(
      builder: (context, state) {
        if (state is XpaletteResultState) {
          return WillPopScope(
            onWillPop: () async{
              BlocProvider.of<XpaletteCubit>(context).emit(XpaletteInitialState());
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Result'),
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image(
                        image: state.image.image!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      // child: GridView.extent(
                      //   maxCrossAxisExtent: 90,
                      //   children: [
                      //     BigBoxColored(color: Color(0xFFFFFF00)),
                      //     BigBoxColored(color: Color(0xFF00FF88)),
                      //     BigBoxColored(color: Color(0xFF00FF88)),
                      //     BigBoxColored(color: Color(0xFF00FFFF)),
                      //     BigBoxColored(color: Color(0xFF00FF00)),
                      //     BigBoxColored(color: Color(0xFF00FF88)),
                      //     BigBoxColored(color: Color(0xFFAAFF00)),
                      //     BigBoxColored(color: Color(0xFF00FF88)),
                      //     BigBoxColored(color: Color(0xFF00FF88)),
                      //   ],
                      // ),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 90),
                          itemCount: state.image.colors!.length,
                          itemBuilder: (context, index) {
                            return BigBoxColored(
                                color: state.image.colors!.elementAt(index));
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
