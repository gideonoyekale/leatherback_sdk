class PaymentParam {
  int? amount;
  String? channel;
  String? currency;
  String? narration;
  Link? link;
  String? reference;
  CustomerInformation? userInformation;
  PaymentRequestProps? paymentRequestProps;
  Map<String, dynamic>? metaData;

  PaymentParam({
    this.amount,
    this.channel,
    this.currency,
    this.narration,
    this.link,
    this.userInformation,
    this.paymentRequestProps,
    this.metaData,
    this.reference,
  });

  PaymentParam.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    channel = json['channel'];
    currency = json['currency'];
    narration = json['narration'];
    reference = json['reference'];
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
    userInformation = json['userInformation'] != null
        ? CustomerInformation.fromJson(json['userInformation'])
        : null;
    paymentRequestProps = json['paymentRequestProps'] != null
        ? PaymentRequestProps.fromJson(json['paymentRequestProps'])
        : null;
    metaData = json['metaData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['channel'] = channel;
    data['currency'] = currency;
    data['narration'] = narration;
    data['reference'] = reference;
    if (link != null) {
      data['link'] = link!.toJson();
    }
    if (userInformation != null) {
      data['userInformation'] = userInformation!.toJson();
    }
    if (paymentRequestProps != null) {
      data['paymentRequestProps'] = paymentRequestProps!.toJson();
    }
    if (metaData != null) data['metaData'] = metaData;
    return data;
  }
}

class Link {
  String? alias;

  Link({this.alias});

  Link.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    return data;
  }
}

class CustomerInformation {
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? phone;

  CustomerInformation(
      {this.firstName, this.lastName, this.emailAddress, this.phone});

  CustomerInformation.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailAddress = json['emailAddress'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailAddress'] = emailAddress;
    data['phone'] = phone;
    return data;
  }
}

class PaymentRequestProps {
  PaymentCard? card;
  String? returnUrl;

  PaymentRequestProps({this.card, this.returnUrl});

  PaymentRequestProps.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? PaymentCard.fromJson(json['card']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (card != null) {
      data['card'] = card!.toJson();
    }
    data['returnUrl'] = returnUrl;
    return data;
  }
}

class PaymentCard {
  String? cardNumber;
  String? cvv;
  String? expiryDate;
  int? expMonth;
  int? expYear;
  String? number;

  PaymentCard(
      {this.cardNumber,
      this.cvv,
      this.expiryDate,
      this.expMonth,
      this.expYear,
      this.number});

  PaymentCard.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    cvv = json['cvv'];
    expiryDate = json['expiryDate'];
    expMonth = json['expMonth'];
    expYear = json['expYear'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['cardNumber'] = cardNumber;
    data['cvv'] = cvv;
    // data['expiryDate'] = expiryDate;
    data['expMonth'] = expMonth;
    data['expYear'] = expYear;
    data['number'] = number;
    return data;
  }
}
