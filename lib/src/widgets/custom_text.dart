import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText({
    required this.text,
    this.size = 15,
    this.color = AppColors.black,
    this.weight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.overflow,
    this.maxLines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        decoration: textDecoration,
      ),
      // ),
    );
  }
}
