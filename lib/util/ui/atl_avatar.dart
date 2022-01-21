import 'package:flutter/material.dart';

import '/util/constants/ui_constants.dart';
import '/util/ui/atl_text.dart';
import 'alt_gradiant_widget.dart';

class ATLAvatar extends StatefulWidget {
  final String? avtrType;
  final String? avtrUrl;
  final String? avtrTxt;
  final double? radius;
  final IconData? icon;
  final Color? iconColor;
  final String? navgTonextPageTxt;
  final double? textFontSize;

  final Function()? avtrClickEvent;

  const ATLAvatar(
      {Key? key,
      required this.avtrType,
      this.avtrUrl,
      this.avtrTxt,
      this.radius,
      this.icon,
      this.iconColor,
      this.navgTonextPageTxt,
      this.avtrClickEvent,
      this.textFontSize})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ATLAvatarState();
}

class ATLAvatarState extends State<ATLAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.avtrType == "IMAGE") {
      return getAvatarImage();
    } else if (widget.avtrType == "TEXT") {
      return getAvatarText();
    } else if (widget.avtrType == "ICON") {
      return getAvatarIcon();
    } else {
      return Container();
    }
  }

  Widget getAvatarImage() {
    return GestureDetector(
      onTap: () {
        // widget.avtrClickEvent!();
      },
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: AssetImage(widget.avtrUrl ?? ''),
      ),
      // backgroundColor: ATLColorConstants.AVTR_SEC_WHITE,
    );
  }

  Widget getAvatarText() {
    return CircleAvatar(
      radius: ATLUIConstants.avtrRadius,
      child: ATLText(
        txt: widget.avtrTxt ?? "",
        fontSize: widget.textFontSize,
      ),
    );
  }

  Widget getAvatarIcon() {
    return CircleAvatar(
      radius: ATLUIConstants.avtrRadius,
      backgroundColor: Colors.white12,
      // foregroundColor: Colors.white30,
      child: ATLGradintWidget(
        child: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
      ),
      // Icon(
      //   widget.icon,
      //   color: widget.iconColor,
      // ),
    );
  }
}
