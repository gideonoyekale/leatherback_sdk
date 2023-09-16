import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/decorations.dart';
import '../widgets/app_text.dart';
import '../widgets/spacing.dart';

class FinalisePaymentScreen extends StatefulWidget {
  final int amount;
  final String currency;

  const FinalisePaymentScreen({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  @override
  State<FinalisePaymentScreen> createState() => _FinalisePaymentScreenState();
}

class _FinalisePaymentScreenState extends State<FinalisePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      showGoBack: false,
      showClose: false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppContainer(
              color: Palette.primary,
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.lbLogo,
                    height: 20,
                    package: Constants.packageName,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const AppText(
                          'AMOUNT',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        const Spacing.tinyHeight(),
                        AppText(
                          '${widget.currency} ${widget.amount}',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppContainer(
              color: Colors.white,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              image: Decorations.darkLinePattern,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    Assets.processingLoader,
                    height: MediaQuery.of(context).size.height * 0.25,
                    package: Constants.packageName,
                  ),
                  const Spacing.mediumHeight(),
                  const AppText(
                    'Transaction Processing',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacing.smallHeight(),
                  const AppText(
                    'Please wait while your transaction is processing',
                    fontSize: 16,
                    color: Palette.textGrey,
                    alignment: TextAlign.center,
                  ),
                  const Spacing.largeHeight(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
