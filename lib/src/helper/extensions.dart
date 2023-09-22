import 'package:flutter/material.dart';

extension SizeHelper on BuildContext {
  double get mWidth => MediaQuery.of(this).size.width;

  double get mHeight => MediaQuery.of(this).size.height;
}

extension EmptyPaddding on num {
  SizedBox get ph => SizedBox(height: toDouble());

  SizedBox get pw => SizedBox(width: toDouble());
}

extension DoubleExtensions on double {
  /// Calculates the specified percentage of the value
  double getPercentageAmount(double percentage) {
    return this * percentage / 100;
  }

  /// Returns `double` with the given number of decimal places
  double dToPrecision({int? digitsAfterDecimal}) =>
      double.parse(toStringAsFixed(digitsAfterDecimal ?? 2));
}

extension CapExtension on String {
  String get firstInCaps =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.firstInCaps)
      .join(' ');

  /// Convert a string to plural.
  ///
  /// By ```Default``` the tail added to the string will be ```s```.
  ///
  /// Pass your own tail string to ```tailString``` parameter.
  String toPlural({String? tailString = 's'}) => '$this$tailString';
}
