import 'dart:ui';
import 'package:flutter/material.dart';

class BoundingTextSize {
  late Locale locale;

  // TextStyle style = Theme.of(context).textTheme.titleMedium!;
  // fontFamily Segoe UI
  // fontSize 16
  // fontWeight w400
  // textBaseline alphabetic

  BoundingTextSize(BuildContext context) {
    this.locale = Localizations.localeOf(context);
    return;
  }

  Size getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: locale,
        text: TextSpan(text: text, style: style),
        maxLines: null)
      ..layout();

    return textPainter.size;
  }
}
