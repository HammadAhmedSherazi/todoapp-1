class TodoModule {
  String? sId;
  String? userId;
  String? title;
  String? desc;
  bool? isCheck;
  int? iV;

  TodoModule({this.sId, this.userId, this.title, this.desc, this.iV, this.isCheck});

  TodoModule.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    title = json['title'];
    desc = json['desc'];
    iV = json['__v'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['title'] = title;
    data['desc'] = desc;
    data['__v'] = iV;
    data['isCheck'] = isCheck;
    return data;
  }
}

// class TodoModule {
//   TodoModule({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.completed,
//   });
//   late final int userId;
//   late final int id;
//   late final String title;
//   late final bool completed;
  
//   TodoModule.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     id = json['id'];
//     title = json['title'];
//     completed = json['completed'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['id'] = id;
//     data['title'] = title;
//     data['completed'] = completed;
//     return data;
//   }
// }