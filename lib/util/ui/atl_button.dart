import 'package:flutter/material.dart';
import '/util/constants/color_constants.dart';
import '/util/ui/atl_text.dart';

class ATLButton extends StatefulWidget {
  final String btnType;
  final String btnText;
  final String? title;
  final IconData? icon;
  final Color? btnColor;
  final BorderRadius? brdrRadius;
  final Function()? onPressed;
  const ATLButton({Key? key, this.btnType = "DEFAULT", required this.btnText, this.title, this.btnColor, this.onPressed, this.brdrRadius, this.icon})
      : super(key: key);

  @override
  _ATLButtonState createState() => _ATLButtonState();
}

class _ATLButtonState extends State<ATLButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.btnType == "GRADIANT") {
      return gradiantButton();
    } else {
      return defaultButton();
    }
  }

  Widget defaultButton() {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: (widget.icon == null)
            ? ATLText(txt: widget.btnText)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(widget.icon), ATLText(txt: widget.btnText)],
              ));
  }

  Widget gradiantButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      // width: 180,
      // height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 1.0],
          colors: [ATLColorConstants.gradient1, ATLColorConstants.gradient2],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            // minimumSize: MaterialStateProperty.all(const Size(50, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: (widget.icon == null)
              ? ATLText(txt: widget.btnText)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(widget.icon), ATLText(txt: widget.btnText)],
                )),
    );
  }

  Widget pickerButton() {
    return Card(
      elevation: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Stack(children: [
            Container(
              // margin: (widget.title != null) ? EdgeInsets.all(AgButtonConstants.margin) : null,
              decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), color: widget.btnColor, borderRadius: widget.brdrRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: ATLText(txt: widget.btnText))),
                  if (widget.icon != null)
                    SizedBox(
                      width: 30,
                      child: Icon(
                        widget.icon,
                        color: Theme.of(context).primaryColor,
                        size: 38,
                      ),
                    ),
                ],
              ),
            ),
            if (widget.title != null)
              Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                      // decoration: BoxDecoration(color: AgButtonConstants.splashColor),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ATLText(txt: widget.title!))),
          ]),
        ),
      ),
    );
  }
}
