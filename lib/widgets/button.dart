import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isLoading;
  final Icon? icon;
  final Color? iconColor;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const Button({
    super.key,
    required this.text,
    this.onClick,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.icon,
    this.iconColor,
    this.borderColor,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey.shade800,
        foregroundColor: textColor ?? Colors.white,
        minimumSize: Size(width ?? double.infinity, height ?? 40),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.grey.shade400),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
      ),
      onPressed: onClick,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor ?? Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: iconColor ?? Colors.yellow,
                        ),
                        padding: EdgeInsets.all(5),
                        child: icon ?? const SizedBox.shrink(),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontSize: fontSize ?? 14,
                  ),
                ),
              ],
            ),
    );
  }
}
