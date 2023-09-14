import 'package:flutter/material.dart';
import 'package:leatherback_sdk/ui/widgets/app_loading.dart';

class DialogService {
  final BuildContext context;
  DialogService(this.context);

  Future<T?> showAppBottomSheet<T>(Widget child) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => child,
    );
  }

  Future<void> showLoading() async =>
      await showAppDialog(const AppLoading(), dismissible: false);

  Future<T?> showAppDialog<T>(
    Widget child, {
    EdgeInsets? padding,
    double? elevation,
    Color? barrierColor,
    bool? dismissible,
  }) async {
    return await showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: dismissible ?? true,
      barrierColor: barrierColor ?? Colors.black87.withOpacity(0.7),

      ///
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        elevation: elevation ?? 0,
        scrollable: false,
        contentPadding: padding ?? EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        content: child,
        // insetPadding: EdgeInsets.zero,
      ),
    );
  }

  void dismiss() => Navigator.of(context).pop();
}
