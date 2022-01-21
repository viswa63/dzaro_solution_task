import 'package:flutter/material.dart';
import 'package:products/util/ui/atl_button.dart';

import 'atl_text.dart';

class ATLAlertDialog {
  ///   This is used for Yes or no User Questining and returns callback True or false. If True do u r logic else false
  static Future<void> getYesOrNoAlertDialog(
      BuildContext context, String title, String description, String btnTextYes, String btnTextNo, Function(bool) returnResponse) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ATLText(txt: title),
          content: ATLText(txt: description),
          actions: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(3),
                child: ATLText(txt: btnTextNo),
              ),
              onTap: () {
                Navigator.pop(context);
                returnResponse(false);
              },
            ),
            ATLButton(
              btnText: btnTextYes,
              onPressed: () {
                Navigator.pop(context);
                returnResponse(true);
              },
            ),
          ],
        );
      },
    );
  }
}
