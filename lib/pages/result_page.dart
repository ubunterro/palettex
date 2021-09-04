import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/components/big_box_colored.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<XpaletteCubit, XpaletteState>(
      builder: (context, state) {
        if (state is XpaletteResultState) {
          if (state.showSavedPopup) {
            state.showSavedPopup = false;
            Future.delayed(const Duration(milliseconds: 1000), () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.grey,
                  content: Text('Сохранено в галерею')));
            });
          }
          return WillPopScope(
            onWillPop: () async {
              BlocProvider.of<XpaletteCubit>(context)
                  .emit(XpaletteLibraryLoadedState());
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Результат'),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Удалено')));
                        BlocProvider.of<XpaletteCubit>(context)
                            .deleteImage(state.image);
                      },
                      child: Text('Удалить'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
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
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
