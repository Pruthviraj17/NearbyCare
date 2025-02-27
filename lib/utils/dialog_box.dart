import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hospitals/widgets/components/custom_text_widget.dart';

void showDialogBox({
  required BuildContext context,
  String? title,
  String? content,
  void Function()? onPressed,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
              title != null
                  ? CustomTextWidget(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )
                  : null,
          content:
              content != null
                  ? CustomTextWidget(
                    text: content,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
                  : null,
          actions: [
            CupertinoDialogAction(
              child: CustomTextWidget(
                text: "Cancel",
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.normal,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
              child: CustomTextWidget(
                text: "Ok",
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title:
              title != null
                  ? CustomTextWidget(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )
                  : null,
          content:
              content != null
                  ? CustomTextWidget(
                    text: content,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
                  : null,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomTextWidget(
                text: "Cancel",
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
              child: CustomTextWidget(
                text: "Ok",
                fontSize: 14,
                fontWeight: FontWeight.normal,

                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
