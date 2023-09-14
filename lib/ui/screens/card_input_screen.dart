import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/models/models.dart';
import 'package:leatherback_sdk/ui/widgets/app_button.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/app_text_field.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../widgets/app_text.dart';
import '../widgets/spacing.dart';

class CardInputScreen extends StatefulWidget {
  final int amount;
  final String currency;

  const CardInputScreen({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  @override
  State<CardInputScreen> createState() => _CardInputScreenState();
}

class _CardInputScreenState extends State<CardInputScreen> {
  final _cardFormatter = MaskTextInputFormatter(
    mask: '#### - #### - #### - ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final _dateFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final _cardNumberTC = TextEditingController();
  final _cvvTC = TextEditingController();
  final _dateTC = TextEditingController();
  String _number = '', _cvv = '', _date = '';
  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      showGoBack: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
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
              Expanded(
                child: SingleChildScrollView(
                  child: AppContainer(
                    color: Colors.white,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          'Enter your card credentials to continue with payment',
                          color: Palette.textGrey,
                        ),
                        const Spacing.mediumHeight(),
                        const WarningCard(),
                        const Spacing.bigHeight(),
                        const AppText(
                          'Card Number',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Palette.textBlack,
                        ),
                        const Spacing.smallHeight(),
                        AppTextField(
                          controller: _cardNumberTC,
                          maxLines: 1,
                          hintText: '0000 - 0000 - 0000 - 0000',
                          counter: Container(),
                          textInputType: TextInputType.phone,
                          inputFormatters: [_cardFormatter],
                          onChanged: (val) {
                            _number = val;
                            setState(() {});
                          },
                        ),
                        const Spacing.mediumHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    'CVV Number',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textBlack,
                                  ),
                                  const Spacing.smallHeight(),
                                  AppTextField(
                                    controller: _cvvTC,
                                    maxLines: 1,
                                    hintText: '•••',
                                    maxLength: 3,
                                    obscureText: true,
                                    obscureChar: '•',
                                    counter: Container(),
                                    textInputType: TextInputType.phone,
                                    onChanged: (val) {
                                      _cvv = val;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacing.mediumWidth(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    'Expiry',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textBlack,
                                  ),
                                  const Spacing.smallHeight(),
                                  AppTextField(
                                    maxLines: 1,
                                    hintText: '02/16',
                                    controller: _dateTC,
                                    counter: Container(),
                                    textInputType: TextInputType.phone,
                                    inputFormatters: [_dateFormatter],
                                    onChanged: (val) {
                                      _date = val;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacing.bigHeight(),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                onPressed: () => Navigator.pop(context),
                                title: 'Cancel',
                                textColor: Palette.textBlack,
                                color: Palette.disabled,
                              ),
                            ),
                            const Spacing.mediumWidth(),
                            Expanded(
                              child: AppButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                  PaymentCard(
                                    number: _number.replaceAll(' - ', ''),
                                    cardNumber: _number.replaceAll(' - ', ' '),
                                    cvv: _cvv,
                                    expiryDate: _date,
                                    expMonth: int.parse(_date.split('/')[0]),
                                    expYear:
                                        int.parse(_date.split('/')[1]) + 2000,
                                  ),
                                ),
                                title: 'Pay Now',
                                active: _number.replaceAll(' - ', '').length ==
                                        16 &&
                                    _date.replaceAll('/', '').length == 4 &&
                                    _cvv.length == 3,
                              ),
                            ),
                          ],
                        ),
                        const Spacing.smallHeight(),
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
}

class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      borderColor: Palette.secondary,
      color: Palette.secondaryLight,
      radius: 12,
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.cautionIcon,
            package: Constants.packageName,
          ),
          const Spacing.mediumWidth(),
          const Expanded(
            child: AppText(
              'Kindly be aware that at this moment, we solely accept payments made with Mastercard and Visa cards.',
              color: Palette.secondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
