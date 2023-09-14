import 'package:intl/intl.dart';
import 'package:leatherback_sdk/core/enums/channel.dart';

extension StringExtensions on String? {
  Channel get getChannel {
    if (this == Channel.card.slug) {
      return Channel.card;
    } else if (this == Channel.transfer.slug) {
      return Channel.transfer;
    } else if (this == Channel.account.slug) {
      return Channel.account;
    } else {
      return Channel.unknown;
    }
  }

  bool get isNgn => this == 'NGN';
}

extension DoubleExtension on double? {
  String get currencyFormat {
    if (this == null) return '';
    final format = NumberFormat("#,##0.00", "en_US");
    return format.format(this!);
  }

  String get currencyMFormat {
    if (this == null) return '';

    final format = NumberFormat("#,##0.00", "en_US");
    if (this! < 1000000) {
      return format.format(this!);
    } else {
      double newVal = this! / 1000000;
      return '${newVal.toStringAsFixed(2)}M';
    }
  }
}

extension IntExtension on int? {
  String get currencyFormat {
    if (this == null) return '';
    final format = NumberFormat("#,##0", "en_US");
    return format.format(this!);
  }

  String get countdownFormat {
    if (this == null) return '';
    final minutes = (this! / 60).floor().toString().padLeft(2, '0');
    final seconds = (this! % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
