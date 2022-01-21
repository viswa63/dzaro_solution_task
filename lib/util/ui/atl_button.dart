import 'package:flutter/material.dart';
import '/util/constants/color_constants.dart';
import '/util/ui/atl_text.dart';

class ATLButton extends StatefulWidget {
  final String btnText;
  final IconData? icon;
  final Function()? onPressed;
  const ATLButton({Key? key, required this.btnText, this.onPressed, this.icon}) : super(key: key);

  @override
  _ATLButtonState createState() => _ATLButtonState();
}

class _ATLButtonState extends State<ATLButton> {
  @override
  Widget build(BuildContext context) {
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
}
