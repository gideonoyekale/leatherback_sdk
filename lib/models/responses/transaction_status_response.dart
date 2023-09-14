import '../models.dart';

class TransactionStatusResponse {
  String? paymentReference;
  Amount? amount;
  int? paymentStatus;

  TransactionStatusResponse({
    this.paymentReference,
    this.amount,
    this.paymentStatus,
  });

  TransactionStatusResponse.fromJson(Map<String, dynamic> json) {
    paymentReference = json['paymentReference'];
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentReference'] = paymentReference;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    data['paymentStatus'] = paymentStatus;
    return data;
  }
}
