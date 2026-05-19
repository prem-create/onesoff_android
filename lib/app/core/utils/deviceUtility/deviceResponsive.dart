import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class DeviceResponsive {
  DeviceResponsive._();

  static const double _designWidth = 390;
  static const double _designHeight = 844;
  static const double _minPhoneWidth = 320;
  static const double _maxPhoneWidth = 480;

  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);
  static double _clampedScreenWidth(BuildContext context) {
    return screenSize(context)
        .width
        .clamp(_minPhoneWidth, _maxPhoneWidth)
        .toDouble();
  }

  static double widthScale(BuildContext context) {
    return _clampedScreenWidth(context) / _designWidth;
  }

  static double heightScale(BuildContext context) {
    return screenSize(context).height / _designHeight;
  }

  static double w(BuildContext context, double size) {
    return size * widthScale(context);
  }

  static double h(BuildContext context, double size) {
    return size * heightScale(context);
  }

  static double r(BuildContext context, double size) {
    return size * math.min(widthScale(context), heightScale(context));
  }

  static double systemTextScale(
    BuildContext context, {
    double min = 1.0,
    double max = 1.35,
  }) {
    return MediaQuery.textScalerOf(context).scale(1).clamp(min, max).toDouble();
  }

  static double sp(
    BuildContext context,
    double fontSize, {
    double minScale = 0.88,
    double maxScale = 1.30,
  }) {
    // Keep font size device-adaptive only.
    // Flutter's Text already applies MediaQuery text scaling automatically.
    final double deviceScale = widthScale(context).clamp(minScale, maxScale).toDouble();
    return fontSize * deviceScale;
  }

  static double fluid(
    BuildContext context, {
    required double min,
    required double max,
    double minWidth = _minPhoneWidth,
    double maxWidth = _maxPhoneWidth,
  }) {
    final double currentWidth = screenSize(context).width;
    final double normalized = ((currentWidth - minWidth) / (maxWidth - minWidth))
        .clamp(0, 1)
        .toDouble();
    return min + ((max - min) * normalized);
  }
}
