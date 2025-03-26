import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTaps,
    required this.buttonTitle,
    required this.colors,
    this.textColor,
    this.textFontSize,
    this.height = 48,
    this.hasRadius = true,
    this.hasBorder = false,
    this.borderColor = Colors.white,
    this.borderRadius = 8,
    this.fontWeight = FontWeight.w500,
    this.icon,
  });
  final VoidCallback? onTaps;
  final String buttonTitle;
  final Color? colors;
  final Color? textColor;
  final double? textFontSize;
  final double? height;
  final bool hasRadius;
  final bool hasBorder;
  final Color borderColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTaps,
      child: Container(
        width: size.width,
        height: height ?? size.height * 0.06,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(hasRadius ? borderRadius : 0),
          border: hasBorder ? Border.all(color: borderColor, width: 0.5) : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8),
              ],
              Text(
                buttonTitle,
                style: TextStyle(
                  fontSize: textFontSize ?? 16,
                  fontWeight: fontWeight,
                  color: textColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
