import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hospitals/widgets/components/custom_text_widget.dart';

void showDialogBox({
  required BuildContext context,
  String? title,
  String? content,
  void Function()? onPressed,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: CustomTextWidget(text: title ?? ""),
        content: CustomTextWidget(
          text: content ?? "",
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        actions: [
          CupertinoDialogAction(
            child: CustomTextWidget(
              text: "Cancel",
              color: Colors.black,
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
              text: "OK",
              color: Colors.red,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
    },
  );
}
