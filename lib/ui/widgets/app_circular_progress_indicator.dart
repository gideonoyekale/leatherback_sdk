import 'package:flutter/material.dart';
import 'package:leatherback_sdk/core/theme/palette.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    Key? key,
    this.size,
    this.color,
    this.margin,
  }) : super(key: key);
  final double? size;
  final Color? color;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return size == null
        ? Center(
            child: Container(
              margin: margin,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color ?? Palette.primary,
              ),
            ),
          )
        : Center(
            child: Container(
              width: size,
              height: size,
              margin: margin,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color ?? Palette.primary,
              ),
            ),
          );
  }
}
