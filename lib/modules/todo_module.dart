class TodoModule {
  String? sId;
  String? userId;
  String? title;
  String? desc;
  int? iV;

  TodoModule({this.sId, this.userId, this.title, this.desc, this.iV});

  TodoModule.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    title = json['title'];
    desc = json['desc'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['title'] = title;
    data['desc'] = desc;
    data['__v'] = iV;
    return data;
  }
}
