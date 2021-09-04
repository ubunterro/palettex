import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Закруглённая плитка цвета в палитре
class BigBoxColored extends StatelessWidget {
  const BigBoxColored({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey();
    final String colorCode = '#${color.red.toRadixString(16)}'
                             '${color.green.toRadixString(16)}'
                             '${color.blue.toRadixString(16)}';

    return GestureDetector(
      onTap: () {
        final dynamic tooltip = key.currentState;
        tooltip.ensureTooltipVisible();
      },
      onDoubleTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:
              Text('Скопированно')));
              Clipboard.setData(ClipboardData(text: colorCode));
      },
      child: Tooltip(
        excludeFromSemantics: true,
        preferBelow: false,
        message: '$colorCode \n'
                 'Нажмите дважды чтобы скопировать код',
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
