import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/cores.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final String? title, titleFontFamily;
  final Function()? onPressed;
  final Widget? child, prefix;
  final bool? loading, active;
  final MainAxisAlignment? mainAxisAlignment;
  final double? titleFontSize;
  final Color? color,
      textColor,
      hoverColor,
      disableTextColor,
      disableColor,
      borderColor;
  final double? elevation, disableElevation, radius, borderWidth, height, width;
  final BorderStyle? borderStyle;
  const AppButton({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.elevation,
    this.hoverColor,
    this.disableTextColor,
    this.disableColor,
    this.disableElevation,
    this.radius,
    this.padding,
    this.margin,
    this.loading,
    this.mainAxisAlignment,
    this.borderColor,
    this.borderWidth,
    this.borderStyle,
    this.height,
    this.width,
    this.title,
    this.textColor,
    this.prefix,
    this.active,
    this.titleFontSize,
    this.titleFontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: margin,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(
                    width: borderWidth ?? 1,
                    color: borderColor ?? Palette.primary,
                    style: borderStyle ?? BorderStyle.solid,
                  ),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          color: (active ?? true)
              ? (color ?? Palette.primary)
              : (disableColor ?? Palette.disabled),
          elevation: elevation ?? 0,
          minWidth: 0,
          height: height ?? 48,
          hoverColor: hoverColor,
          disabledColor: disableColor,
          disabledTextColor: disableTextColor,
          disabledElevation: disableElevation,
          padding: padding ?? const EdgeInsets.all(0),
          onPressed: (active ?? true) ? onPressed : () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: prefix!,
                    ),
                  !(loading ?? false)
                      ? Expanded(
                          child: AppText(
                            title ?? '',
                            fontSize: titleFontSize ?? 16,
                            alignment: TextAlign.center,
                            color: (active ?? true)
                                ? (textColor ?? Colors.white)
                                : Palette.disabledText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : const CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                  // if (loading ?? false)
                  //   Container(
                  //     margin: const EdgeInsets.only(left: 8),
                  //     child: const AppCircularProgressIndicator(
                  //       size: 20,
                  //       color: AppColors.white,
                  //     ),
                  //   )
                ],
              )),
    );
  }
}
