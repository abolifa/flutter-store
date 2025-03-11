import 'package:flutter/material.dart';

class PhoneInput extends StatelessWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneController;
  final String? hintText;
  final String? label;
  final Color? textColor;
  final Color? borderColor;
  final Color? fillColor;
  final double? borderRadius;
  final double? fontSize;
  final double? height;
  final double? width;

  const PhoneInput({
    super.key,
    required this.countryCodeController,
    required this.phoneController,
    this.hintText,
    this.label,
    this.textColor,
    this.borderColor,
    this.fillColor,
    this.borderRadius,
    this.fontSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: phoneController,
            decoration: InputDecoration(
              label: label != null ? Text(label!) : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width ?? 10,
                vertical: height ?? 0,
              ),
              fillColor: fillColor ?? Colors.white,
              filled: true,
              hintStyle: TextStyle(
                color: textColor ?? Colors.grey,
                fontSize: fontSize ?? 12,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: TextField(
            controller: countryCodeController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width ?? 10,
                vertical: height ?? 0,
              ),
              fillColor: fillColor ?? Colors.white,
              filled: true,
              hintStyle: TextStyle(
                color: textColor ?? Colors.grey,
                fontSize: fontSize ?? 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
