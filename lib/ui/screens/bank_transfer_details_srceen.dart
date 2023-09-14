import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/core/extension.dart';
import 'package:leatherback_sdk/models/models.dart';
import 'package:leatherback_sdk/ui/widgets/app_button.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';

import '../../core/constants/decorations.dart';
import '../widgets/app_text.dart';
import '../widgets/spacing.dart';

class BankTransferDetailsScreen extends StatefulWidget {
  final int amount;
  final String currency;
  final TransferInfo transferInfo;

  const BankTransferDetailsScreen({
    Key? key,
    required this.amount,
    required this.currency,
    required this.transferInfo,
  }) : super(key: key);

  @override
  State<BankTransferDetailsScreen> createState() =>
      _BankTransferDetailsScreenState();
}

class _BankTransferDetailsScreenState extends State<BankTransferDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _calculateExpiryTime();
  }

  void _calculateExpiryTime() {
    if (widget.transferInfo.expiration == null) return;
    final today = DateTime.now();
    _remTime.value =
        (widget.transferInfo.expiration!).difference(today).inSeconds;
    Console.log('TIME_REM', _remTime.value);
    _start();
  }

  final ValueNotifier<int?> _remTime = ValueNotifier<int?>(null);
  Timer? _timer;

  _listener() {
    setState(() {});
    _start();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remTime.value == 0) {
        _timer?.cancel();
        Navigator.pop(context, false);
      } else {
        _remTime.value = _remTime.value! - 1;
        setState(() {});
        Console.log('TIME_REM', _remTime.value);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer?.isActive ?? false) _timer?.cancel();
    _remTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      showGoBack: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
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
                            '${widget.currency} ${widget.amount.currencyFormat}',
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
              Expanded(
                child: SingleChildScrollView(
                  child: AppContainer(
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
                        const Spacing.mediumHeight(),
                        const AppText(
                          'One Time Transfer',
                          color: Palette.black,
                          alignment: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacing.mediumHeight(),
                        const AppText(
                          'AMOUNT',
                          color: Palette.black,
                          alignment: TextAlign.center,
                          fontSize: 14,
                        ),
                        const Spacing.tinyHeight(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              widget.currency,
                              color: Palette.black,
                              alignment: TextAlign.center,
                              fontSize: 16,
                            ),
                            const Spacing.tinyWidth(),
                            AppText(
                              widget.amount.currencyFormat,
                              color: Palette.black,
                              alignment: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ],
                        ),
                        const Spacing.mediumHeight(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text.rich(
                            TextSpan(
                              text: 'Use your ',
                              children: [
                                TextSpan(
                                  text: 'Internet/Mobile Banking',
                                  style: boldTextStyle,
                                ),
                                const TextSpan(text: ' to deposit this '),
                                TextSpan(
                                  text: 'exact amount',
                                  style: boldTextStyle,
                                ),
                                const TextSpan(
                                    text: ' into this account number'),
                              ],
                            ),
                            style: normalTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacing.mediumHeight(),
                        AppContainer(
                          radius: 12,
                          color: Palette.primary.withOpacity(0.1),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AccountDetailsItem(
                                title: 'Account Number:',
                                value: widget.transferInfo.accountNumber ?? '',
                              ),
                              const Spacing.smallHeight(),
                              AccountDetailsItem(
                                title: 'Bank Name:',
                                value: widget.transferInfo.bank ?? '',
                              ),
                              const Spacing.smallHeight(),
                              AccountDetailsItem(
                                title: 'Account Name:',
                                value: widget.transferInfo.accountName ?? '',
                              ),
                            ],
                          ),
                        ),
                        const Spacing.mediumHeight(),
                        if (_remTime.value != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: 'Expires in ',
                                children: [
                                  TextSpan(
                                    text: _remTime.value!.countdownFormat,
                                    style: boldTextStyle,
                                  ),
                                ],
                              ),
                              style: normalTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        const Spacing.mediumHeight(),
                        AppButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          title: 'I have paid',
                        ),
                        const Spacing.bigHeight(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get normalTextStyle => GoogleFonts.roboto();

  TextStyle get boldTextStyle => GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
      );
}

class TransferInstruction extends StatelessWidget {
  const TransferInstruction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text.rich(
        TextSpan(
          text: 'Use your ',
          children: [
            TextSpan(text: 'Internet/Mobile Banking'),
            TextSpan(text: ' to deposit this '),
            TextSpan(text: 'exact amount'),
            TextSpan(text: ' into this account number'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AccountDetailsItem extends StatelessWidget {
  const AccountDetailsItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          title,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(flex: 1),
        AppText(value),
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: const Icon(
              Icons.copy,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }
}
