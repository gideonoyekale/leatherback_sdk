class Amount {
  String? currencyCode;
  double? amount;

  Amount({this.currencyCode, this.amount});

  Amount.fromJson(Map<String, dynamic> json) {
    currencyCode = json['currencyCode'];
    amount = json['amount'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currencyCode'] = currencyCode;
    data['amount'] = amount;
    return data;
  }
}
