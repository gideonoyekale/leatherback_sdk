import 'package:leatherback_sdk/core/extension.dart';

import '../../core/enums/channel.dart';
import '../payment_channel.dart';

class ValidatePaymentResponse {
  bool? isValid;
  List<PaymentChannel>? channels;

  ValidatePaymentResponse({this.isValid, this.channels});

  ValidatePaymentResponse.fromJson(Map<String, dynamic> json) {
    isValid = json['isValid'];
    if (json['channels'] != null) {
      channels = <PaymentChannel>[];
      json['channels'].forEach((v) {
        channels!.add(PaymentChannel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValid'] = isValid;
    if (channels != null) {
      data['channels'] = channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Channel> get channelsList =>
      (channels ?? []).map((e) => e.alias.getChannel).toList();
}
