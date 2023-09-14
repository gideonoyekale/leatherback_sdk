import '../models.dart';

class ValidatePaymentParam {
  Amount? amount;
  List<String>? channels;

  ValidatePaymentParam({this.amount, this.channels});

  ValidatePaymentParam.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    channels = json['channels'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    data['channels'] = channels;
    return data;
  }
}
