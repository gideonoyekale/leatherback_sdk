class LeatherbackException implements Exception {
  LeatherbackException(this.message, [this.data]);

  final String message;
  final dynamic data;

  factory LeatherbackException.fromHttp(Map<String, dynamic> json) =>
      LeatherbackException(
        json["detail"] ?? 'Your payment was not successful',
        json['data'],
      );

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LeatherbackException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
