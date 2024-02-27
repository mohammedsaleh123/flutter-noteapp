import 'package:flutter/material.dart';
import 'package:noteapp/consts/color_const.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      required this.text,
      this.color = darkColor,
      this.textSize = 16,
      this.maxLines,
      this.fontWeight,
      this.textOverflow});
  final String text;
  final Color color;
  final double textSize;
  int? maxLines;
  FontWeight? fontWeight;
  TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: textSize, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
