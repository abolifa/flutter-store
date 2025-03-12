import 'package:app/helpers/constant.dart';
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

  static String getNetworkImage(String url) {
    return '${Constant.imageUrl}$url';
  }

  static Widget getProductPrice(double price, double discount) {
    if (discount > 0) {
      final discountedPrice = price - discount;
      final discountedPercent = ((discount / price) * 100).round();
      return Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$discountedPrice د.ل',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            price.toString(),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            '$discountedPercent%',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    } else {
      return Text(
        '$price د.ل',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
