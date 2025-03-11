import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final bool isPassword;
  final Color? textColor;
  final Color? borderColor;
  final Color? fillColor;
  final double? borderRadius;
  final double? fontSize;
  final double? height;
  final double? width;

  const Input({
    super.key,
    required this.controller,
    this.hintText,
    this.isPassword = false,
    this.textColor,
    this.label,
    this.borderColor,
    this.fillColor,
    this.borderRadius,
    this.fontSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: width ?? 10,
          vertical: height ?? 0,
        ),
        fillColor: fillColor ?? Colors.white,
        filled: true,
        hintText: hintText ?? '',
        label: label != null ? Text(label!) : null,
        hintStyle: TextStyle(
          color: textColor ?? Colors.grey,
          fontSize: fontSize ?? 12,
        ),
      ),
    );
  }
}
