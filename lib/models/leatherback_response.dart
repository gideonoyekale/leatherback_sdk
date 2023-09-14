class LeatherbackResponse {
  dynamic data;
  bool isSuccess = false;
  String? error;
  String? message;

  LeatherbackResponse({
    this.data,
    this.isSuccess = false,
    this.error,
    this.message,
  });

  LeatherbackResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    isSuccess = json['isSuccess'] ?? false;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['isSuccess'] = isSuccess;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
