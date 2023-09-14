import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leatherback_sdk/core/constants/constants.dart';

import '../../core/constants/assets.dart';
import 'app_rectangle.dart';
import 'app_text.dart';
import 'spacing.dart';

class BaseDialogScreen extends StatelessWidget {
  final Widget child;
  final bool showClose;
  final bool showGoBack;
  const BaseDialogScreen({
    Key? key,
    required this.child,
    this.showClose = true,
    this.showGoBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          showGoBack ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (showClose && !showGoBack) ...[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const AppContainer(
              shape: BoxShape.circle,
              color: Colors.white,
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
          const Spacing.largeHeight(),
        ],
        if (showGoBack) ...[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const AppContainer(
              radius: 100,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                    size: 12,
                  ),
                  AppText(
                    ' Go Back',
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),
          const Spacing.mediumHeight(),
        ],
        child,
        const Spacing.largeHeight(),
        Center(
          child: SvgPicture.asset(
            Assets.lbSecuredLogo,
            package: Constants.packageName,
          ),
        )
      ],
    );
  }
}
