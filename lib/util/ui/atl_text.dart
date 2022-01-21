import 'package:flutter/material.dart';

class ATLText extends StatefulWidget {
  final String txt;
  final String? linkTxt;
  final TextAlign? txtAlign;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final String? fontFamily;

  final Function(String)? textClickEvent;

  const ATLText(
      {Key? key,
      required this.txt,
      this.linkTxt,
      this.txtAlign,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.fontStyle,
      this.decoration,
      this.decorationColor,
      this.decorationStyle,
      this.letterSpacing,
      this.wordSpacing,
      this.fontFamily,
      this.textClickEvent})
      : super(key: key);
  // var headline;

  @override
  State<StatefulWidget> createState() => ATLTextState();
}

class ATLTextState extends State<ATLText> {
  @override
  Widget build(BuildContext context) {
    return getText();
  }

  Widget getText() {
    return Text(
      widget.txt,
      // textScaleFactor: 1.0,
      textAlign: widget.txtAlign,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        fontStyle: widget.fontStyle,
        letterSpacing: widget.letterSpacing,
        wordSpacing: widget.wordSpacing,
        color: widget.color,
        fontFamily: widget.fontFamily,
      ),
    );
  }
}
