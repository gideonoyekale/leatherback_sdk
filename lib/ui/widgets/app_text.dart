import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize, letterSpacing, height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignment;
  final TextDecoration? textDecoration;
  final TextStyle? style;
  const AppText(this.text,
      {Key? key,
      this.fontSize,
      this.fontStyle,
      this.fontWeight,
      this.color,
      this.maxLines,
      this.overflow,
      this.alignment,
      this.fontFamily,
      this.letterSpacing,
      this.textDecoration,
      this.height,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: style ??
          GoogleFonts.karla(
            color: color,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            decoration: textDecoration,
            height: height,
          ),
      overflow: overflow,
      textAlign: alignment,
    );
    //Raleway,
  }
}

class NairaSign extends StatelessWidget {
  const NairaSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppText('₦', style: GoogleFonts.roboto());
  }
}
