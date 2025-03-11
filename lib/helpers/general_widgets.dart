import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralWidgets {
  static Widget getIcon({
    required String iconName,
    double? size,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/svg/$iconName.svg',
      height: size ?? 20,
      width: size ?? 20,
      color: color ?? Colors.black,
    );
  }
}
