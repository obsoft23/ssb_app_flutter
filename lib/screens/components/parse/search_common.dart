class Common {
  int? id;
  int? categoryId;
  String? vocations;

  int? vocationId;

  Common({this.id, this.categoryId, this.vocations, this.vocationId});

  Common.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    vocations = json['vocations'];

    vocationId = json['vocation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['vocations'] = vocations;

    data['vocation_id'] = vocationId;
    return data;
  }
}
