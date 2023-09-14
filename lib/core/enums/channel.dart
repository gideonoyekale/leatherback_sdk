import 'package:leatherback_sdk/core/constants/assets.dart';

enum Channel {
  card('Card', 'Pay with Card', Assets.cardIcon),
  transfer('PayByTransfer', 'Pay by Transfer', Assets.cardIcon),
  account('PayByAccount', 'Pay by Account', Assets.bankIcon),
  unknown('Unknown', 'Unknown', Assets.bankIcon);

  const Channel(this.slug, this.title, this.icon);
  final String slug;
  final String icon;
  final String title;
}
