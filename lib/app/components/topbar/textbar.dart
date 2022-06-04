import 'package:flutter/material.dart';

class textBar extends StatelessWidget {
  final double size;
  final String text;
  final String font;
  final FontWeight fontweight;
  final List<Color> colors;
  const textBar(
      {Key? key,
      this.size = 20,
      this.fontweight = FontWeight.w900,
      required this.text,
      required this.font,
      this.colors = const [Colors.transparent]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          this.text,
          style: TextStyle(
            fontFamily: this.font,
            fontSize: this.size,
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 10
              ..color = colors.length > 1 ? colors[1] : Colors.transparent,
          ),
        ),
        // Solid text as fill.
        Text(
          this.text,
          style: TextStyle(
            fontFamily: this.font,
            fontSize: this.size,
            fontWeight: fontweight,
            color: colors[0],
          ),
        ),
      ],
    );
  }
}
