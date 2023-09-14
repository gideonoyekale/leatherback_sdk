import 'package:leatherback_sdk/core/constants/endpoints.dart';
import 'package:leatherback_sdk/core/enums/payment_status.dart';
import 'package:leatherback_sdk/models/leatherback_exception.dart';
import 'package:leatherback_sdk/models/models.dart';
import 'package:leatherback_sdk/models/responses/finalise_payment_response.dart';
import 'package:leatherback_sdk/services/network_service.dart';

class PaymentService {
  final String _key;
  PaymentService(this._key) : _networkService = NetworkService(_key);

  final NetworkService _networkService;

  Future<ValidatePaymentResponse> validatePayment(
      ValidatePaymentParam param) async {
    final res = await _networkService.post(
      Endpoints.validatePayment,
      body: param.toJson(),
    );
    final validateRes = ValidatePaymentResponse.fromJson(res['value']);
    if (validateRes.isValid ?? false) {
      return validateRes;
    } else {
      throw LeatherbackException(res['message']);
    }
  }

  Future<PaymentResponse> initiatePayment(PaymentParam param) async {
    final res = await _networkService.post(
      Endpoints.initiatePayment,
      body: param.toJson(),
    );
    final paymentRes = PaymentResponse.fromJson(res['value']);
    if (paymentRes.paymentStatus == PaymentStatus.failed.title) {
      throw LeatherbackException(
        paymentRes.message ?? 'Payment failed',
        paymentRes.paymentItem?.paymentReference,
      );
    }
    return paymentRes;
  }

  Future<FinalisePaymentResponse> finalisePayment(String ref) async {
    final res = await _networkService.post(
      Endpoints.finalisePayment,
      body: {"paymentReference": ref},
    );
    return FinalisePaymentResponse.fromJson(res['value']);
  }

  Future<TransactionStatusResponse> transactionStatus(String reference) async {
    final res = await _networkService.get(
      Endpoints.transactionStatus(reference),
    );
    final status = TransactionStatusResponse.fromJson(res['value']);

    return status;
  }

  Future<String> getAuth3ds(String reference) async {
    final res = await _networkService.get(
      Endpoints.transactionStatus(reference),
    );
    return res['value']['authenticationhtml'];
  }
}
