import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.text,
      this.onPressed,
      Key? key,
      this.width,
      this.height,
      this.buttonColor,
      this.textColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.buttonStyle,
      this.isLoading = false})
      : super(key: key);
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final ButtonStyle? buttonStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 50,
      child: ElevatedButton(
        style: buttonStyle ??
            ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(
                    buttonColor ?? AppColors.customBlue),
                side: MaterialStateProperty.all(BorderSide(
                    color: borderColor ?? AppColors.customBlue,
                    width: borderWidth ?? 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(25)))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(),
            FittedBox(
              child: Text(
                text,
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            if (isLoading)
              Transform.scale(
                  scale: 0.6,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ))
            else
              const SizedBox()
          ],
        ),
      ),
    );
  }
}
