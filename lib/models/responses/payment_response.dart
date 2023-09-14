class PaymentResponse {
  String? paymentStatus;
  String? message;
  String? bankAuthURL;
  PaymentItem? paymentItem;

  PaymentResponse(
      {this.paymentStatus, this.message, this.bankAuthURL, this.paymentItem});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    paymentStatus = json['paymentStatus'];
    message = json['message'];
    bankAuthURL = json['bankAuthURL'];
    paymentItem = json['paymentItem'] != null
        ? PaymentItem.fromJson(json['paymentItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentStatus'] = paymentStatus;
    data['message'] = message;
    data['bankAuthURL'] = bankAuthURL;
    if (paymentItem != null) {
      data['paymentItem'] = paymentItem!.toJson();
    }
    return data;
  }
}

class PaymentItem {
  String? channel;
  String? message;
  double? totalAmount;
  double? amount;
  double? fees;
  String? reference;
  String? paymentReference;
  Map<String, dynamic>? metaData;

  PaymentItem(
      {this.channel,
      this.message,
      this.amount,
      this.fees,
      this.reference,
      this.paymentReference,
      this.metaData});

  PaymentItem.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    message = json['message'];
    totalAmount = json['totalAmount'] * 1.0;
    amount = json['amount'] * 1.0;
    fees = json['fees'] * 1.0;
    reference = json['reference'];
    paymentReference = json['paymentReference'];
    metaData = json['metaData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['message'] = message;
    data['amount'] = amount;
    data['fees'] = fees;
    data['reference'] = reference;
    data['paymentReference'] = paymentReference;
    data['metaData'] = metaData;
    return data;
  }

  TransferInfo? get transferInfo => metaData != null
      ? TransferInfo.fromJson(metaData!['transfer-info'])
      : null;

  String? get authUrl => metaData != null ? metaData!['AuthUrl'] : null;
}

class TransferInfo {
  String? note;
  String? bank;
  String? accountNumber;
  String? accountName;
  DateTime? expiration;
  String? mode;

  TransferInfo({
    this.note,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.expiration,
    this.mode,
  });

  TransferInfo.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    bank = json['bank'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    expiration = json['expiration'] == null
        ? null
        : DateTime.tryParse(json['expiration']);
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['bank'] = bank;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['expiration'] =
        expiration == null ? null : expiration!.toIso8601String();
    data['mode'] = mode;
    return data;
  }
}
