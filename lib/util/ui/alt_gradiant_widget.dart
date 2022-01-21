import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '/util/constants/color_constants.dart';

class ATLGradintWidget extends StatefulWidget {
  final Widget? child;

  const ATLGradintWidget({Key? key, required this.child}) : super(key: key);

  @override
  _ATLGradintWidgetState createState() => _ATLGradintWidgetState();
}

class _ATLGradintWidgetState extends State<ATLGradintWidget> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return ui.Gradient.linear(
            const Offset(4.0, 24.0),
            const Offset(24.0, 4.0),
            [ATLColorConstants.gradient1, ATLColorConstants.gradient2],
          );
        },
        child: widget.child);
  }
}
