class Endpoints {
  static const String baseUrl = "https://laas.leatherback.co/api/payment";
  static const String validatePayment = "$baseUrl/pay/Validate";
  static const String initiatePayment = "$baseUrl/pay/Initiate";
  static const String getAuth3ds = "$baseUrl/pay/get-auth-3ds";
  static const String finalisePayment = "$baseUrl/pay/Finalize";
  static String transactionStatus(String ref) => "$baseUrl/transactions/$ref";
}
