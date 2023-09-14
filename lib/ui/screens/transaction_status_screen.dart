import 'package:flutter/material.dart';
import 'package:leatherback_sdk/core/constants/decorations.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';

import '../widgets/app_text.dart';
import '../widgets/spacing.dart';

class TransactionStatusScreen extends StatelessWidget {
  final String title, message, buttonTitle, image;

  const TransactionStatusScreen({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonTitle,
    required this.image,
  }) : super(key: key);

  const TransactionStatusScreen.failed({
    this.message = 'Something went wong',
    super.key,
  })  : title = 'Transaction Failed',
        // subtitle = 'Your payment was not successful',
        image = Assets.unsuccessful2,
        buttonTitle = 'Cancel';

  const TransactionStatusScreen.success({super.key})
      : title = 'Transaction Successful',
        message = 'Your payment was completed successfully',
        image = Assets.successful2,
        buttonTitle = 'Continue';

  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      child: AppContainer(
        radius: 12,
        color: Palette.white,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        image: Decorations.darkLinePattern,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height * 0.3,
              package: Constants.packageName,
            ),
            const Spacing.mediumHeight(),
            AppText(
              title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const Spacing.smallHeight(),
            AppText(
              message,
              fontSize: 16,
              color: Palette.textGrey,
              alignment: TextAlign.center,
            ),
            const Spacing.largeHeight(),
          ],
        ),
      ),
    );
  }
}
