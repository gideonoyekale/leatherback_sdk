class FinalisePaymentResponse {
  String? status;
  String? message;

  FinalisePaymentResponse({this.status, this.message});

  FinalisePaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }

  bool get success => status == 'Successful';
}
