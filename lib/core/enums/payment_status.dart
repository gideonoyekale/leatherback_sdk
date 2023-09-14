enum PaymentStatus {
  failed('FAILED'),
  initiated('INITIATED'),
  requireBankAuth('REQUIRED_BANK_AUTH'),
  requireOfflineAction('REQUIRE_USER_OFFLINE_ACTION');

  const PaymentStatus(this.title);
  final String title;
}
