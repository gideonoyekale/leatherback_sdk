//ignore:
library leatherback_sdk;

import 'package:flutter/material.dart';
import 'package:leatherback_sdk/core/enums/channel.dart';
import 'package:leatherback_sdk/core/enums/payment_status.dart';
import 'package:leatherback_sdk/models/leatherback_exception.dart';
import 'package:leatherback_sdk/models/models.dart';
import 'package:leatherback_sdk/ui/screens/bank_transfer_details_srceen.dart';
import 'package:leatherback_sdk/ui/screens/card_auth_screen.dart';
import 'package:leatherback_sdk/ui/screens/card_input_screen.dart';
import 'package:leatherback_sdk/ui/screens/finalise_payment_screen.dart';
import 'package:leatherback_sdk/ui/screens/payment_option_screen.dart';
import 'package:leatherback_sdk/ui/screens/transaction_status_screen.dart';

import 'services/services.dart';

export 'core/cores.dart' show Channel;
export 'models/models.dart' show CustomerInformation;

// const popUp = new LeatherbackPopUp({
// amount: 0,
// currencyCode: "NGN",
// onSuccess: function (arg) {
// console.log(arg, "ARGUMENT");
// },
// key: "sk_test_0f1h622b2h06b9h9e97h6h91a17he4673d55g35",
// showPersonalInformation: true,
// customerEmail: "marcia.cole@leatherback.co",
// disableCloseAfterTransaction: true,
// customerName: "Marcia Cole",
// reference: "HSK877",
// channels: [
// "Card", "PayByTransfer", "PayByAccount"
// ],
// });
// popUp.generatePaymentPopUp();

class LeatherbackSDK {
  DialogService _dialogService;
  PaymentService _paymentService;

  List<Channel> channels;
  Channel? _selected;
  PaymentParam _param = PaymentParam();
  PaymentResponse _paymentResponse = PaymentResponse();
  LeatherbackResponse _response = LeatherbackResponse();
  final int amount;
  final String currency;
  final CustomerInformation customer;
  final String reference;

  // final bool showPersonalInformation;
  final String apikey;
  final BuildContext context;
  bool _isLoading = false;

  LeatherbackSDK({
    required this.context,
    this.channels = const [],
    required this.amount,
    required this.currency,
    required this.customer,
    required this.reference,
    // this.showPersonalInformation = false,
    required this.apikey,
  })  : _dialogService = DialogService(context),
        _paymentService = PaymentService(apikey);

  void _reset() {
    _selected = null;
    _param = PaymentParam();
    _response = LeatherbackResponse();
    _isLoading = false;
    _paymentResponse = PaymentResponse();
  }

  Future<LeatherbackResponse> makePaymentTest() async {
    await _dialogService.showAppDialog(
      CardAuthScreen(
        amount: amount,
        currency: currency,
        html: '',
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (c) => CardAuthScreen(
    //       amount: amount,
    //       currency: currency,
    //       html: '',
    //     ),
    //   ),
    // );
    return _response;
  }

  Future<LeatherbackResponse> makePayment() async {
    try {
      _reset();
      await _validatePayment();
      await _selectPaymentChannel();
      _param = PaymentParam(
        amount: amount,
        channel: _selected?.slug,
        narration: 'Payment from mobile',
        userInformation: customer,
        currency: currency,
        reference: reference,
      );
      if (_selected == Channel.card) {
        await _makePaymentWithCard();
      } else if (_selected == Channel.transfer) {
        await _makePaymentWithBankTransfer();
      }
      return _response;
    } catch (e) {
      await _showError(e.toString());
      return _response;
    }
  }

  Future<void> _makePaymentWithCard() async {
    _closeLoading();
    final res = await _dialogService.showAppDialog(
      CardInputScreen(amount: amount, currency: currency),
    );
    if (res == null) return;
    _param.paymentRequestProps = PaymentRequestProps(
      card: res as PaymentCard,
      returnUrl: "https://pay.leatherback.co/redirect",
    );
    if (currency == 'NGN') {
      _param.metaData = {"redirect-url": "https://pay.leatherback.co/finalize"};
    }
    _showLoading();
    _paymentResponse = await _paymentService.initiatePayment(_param);
    if (_paymentResponse.paymentStatus == PaymentStatus.failed.title) {
      throw LeatherbackException('Transaction Failed!');
    } else if (_paymentResponse.paymentStatus ==
        PaymentStatus.initiated.title) {
      if (currency == 'GBP') {
        await _checkTransactionStatus();
      } else {
        await _finalisePayment();
      }
    } else if (_paymentResponse.paymentStatus ==
        PaymentStatus.requireBankAuth.title) {
      await _completeBankAuth();
    }
  }

  Future<void> _completeBankAuth() async {
    final res = await _paymentService.getAuth3ds(
      _paymentResponse.paymentItem?.reference ?? '',
    );
    _closeLoading();
    final status = await _dialogService.showAppDialog(
      CardAuthScreen(
        amount: amount,
        currency: currency,
        html: res,
      ),
    );
    if (status != null && status) {
      await _finalisePayment();
    } else {
      throw LeatherbackException('Transaction failed!');
    }
  }

  Future<void> _finalisePayment() async {
    _closeLoading();
    _isLoading = true;
    _dialogService.showAppDialog(
      FinalisePaymentScreen(amount: amount, currency: currency),
    );
    final res = await _paymentService.finalisePayment(
      _paymentResponse.paymentItem?.reference ?? '',
    );
    _isLoading = false;
    _dialogService.dismiss();
    if (res.success) {
      await _showSuccess();
    } else {
      throw LeatherbackException(res.message ?? '');
    }
  }

  Future<void> _makePaymentWithBankTransfer() async {
    _paymentResponse = await _paymentService.initiatePayment(_param);
    _closeLoading();
    if (_paymentResponse.paymentStatus == PaymentStatus.failed.title ||
        _paymentResponse.paymentItem?.transferInfo == null) {
      throw LeatherbackException(_paymentResponse.message ?? '');
    } else if (_paymentResponse.paymentStatus ==
        PaymentStatus.requireOfflineAction.title) {
      final res = await _dialogService.showAppDialog(
        BankTransferDetailsScreen(
          amount: amount,
          currency: currency,
          transferInfo: _paymentResponse.paymentItem!.transferInfo!,
        ),
      );
      if (res == null) return;
      if (res as bool) {
        _showLoading();
        await _checkTransactionStatus();
      } else {
        throw LeatherbackException('Transaction Canceled!');
      }
    }
  }

  Future<void> _checkTransactionStatus() async {
    final status = await _paymentService
        .transactionStatus(_paymentResponse.paymentItem?.reference ?? '');
    // if (status.paymentStatus != 0) {
    //   throw LeatherbackException('Transaction Failed');
    // }
    await _showSuccess();
  }

  Future<void> _completeNGNCardPayment(PaymentResponse response) async {
    _dialogService.dismiss();
    final status = await _paymentService
        .transactionStatus(response.paymentItem?.reference ?? '');
  }

  Future<void> _validatePayment() async {
    _showLoading();
    final validateRes = await _paymentService.validatePayment(
      ValidatePaymentParam(
        amount: Amount(
          amount: amount * 1.0,
          currencyCode: currency,
        ),
        channels: channels.map((e) => e.slug).toList(),
      ),
    );
    channels = validateRes.channelsList;
  }

  Future<void> _selectPaymentChannel() async {
    if (channels.isNotEmpty) {
      if (channels.length == 1) {
        _selected = channels.first;
      } else {
        _selected = await _dialogService.showAppDialog(
          PaymentOptionScreen(
            channels: channels,
            amount: amount,
            currency: currency,
          ),
        );
      }
    }
  }

  Future<void> _showLoading() async {
    _isLoading = true;
    await _dialogService.showLoading();
  }

  Future<void> _showSuccess() async {
    _closeLoading();
    await _dialogService.showAppDialog(const TransactionStatusScreen.success());
    _response = LeatherbackResponse(
      isSuccess: true,
      message: 'Payment Successful',
      data: _paymentResponse.paymentItem?.reference,
    );
  }

  Future<void> _showError(String error) async {
    _closeLoading();
    _response = LeatherbackResponse(isSuccess: false, message: error);
    await _dialogService.showAppDialog(
      TransactionStatusScreen.failed(message: error),
    );
  }

  void _closeLoading() {
    if (_isLoading) _dialogService.dismiss();
    _isLoading = false;
  }
}
