import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SvgProvider;
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';

import '../widgets/app_text.dart';
import '../widgets/spacing.dart';

class PaymentOptionScreen extends StatelessWidget {
  final List<Channel> channels;
  final int amount;
  final String currency;

  const PaymentOptionScreen({
    Key? key,
    required this.channels,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      child: AppContainer(
        radius: 12,
        color: Palette.primary,
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        image: const DecorationImage(
          image: SvgProvider.Svg(
            Assets.linePattern,
          ),
          fit: BoxFit.cover,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.lbLogo,
              height: 16,
              package: Constants.packageName,
            ),
            const Spacing.mediumHeight(),
            const AppText(
              'AMOUNT',
              fontSize: 16,
              color: Colors.white,
            ),
            AppText(
              '$currency $amount',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const Spacing.largeHeight(),
            for (var e in channels)
              GestureDetector(
                onTap: () => Navigator.pop(context, e),
                child: AppContainer(
                  radius: 12,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        e.icon,
                        package: Constants.packageName,
                      ),
                      const Spacing.smallWidth(),
                      AppText(
                        e.title,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
