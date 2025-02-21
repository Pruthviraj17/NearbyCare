import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color = Colors.black,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 18,
        color: color,
      ),
    );
  }
}
