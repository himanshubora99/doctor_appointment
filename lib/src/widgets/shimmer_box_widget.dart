import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:flutter/material.dart';

class ShimmerBoxWidget extends StatelessWidget {
  const ShimmerBoxWidget({
    this.w,
    this.h = 10,
    this.borderRadius = 25,
    this.shape = BoxShape.rectangle,
    super.key,
  });

  final double? w;
  final double h;
  final double borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w ?? context.mWidth,
      height: h,
      decoration: BoxDecoration(
          shape: shape,
          color: AppColors.black,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius)),
    );
  }
}
