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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['__v'] = this.iV;
    return data;
  }
}
