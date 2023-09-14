class PaymentChannel {
  String? id;
  String? name;
  String? alias;
  String? description;

  PaymentChannel({this.id, this.name, this.alias, this.description});

  PaymentChannel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['description'] = description;
    return data;
  }
}
