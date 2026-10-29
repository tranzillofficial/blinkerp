import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textDirection,
    this.textScaleFactor,
    this.height,
    this.letterSpacing,
    this.softWrap,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final double? textScaleFactor;
  final double? height;
  final double? letterSpacing;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: TextStyle(
        color: color ??
            Theme.of(context).textTheme.bodyLarge?.color ??
            Theme.of(context).colorScheme.onSurface,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: 'manrope',
        height: height,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      textScaler: TextScaler.linear(textScaleFactor ?? 1.0),
      softWrap: softWrap,
    );
  }
}
