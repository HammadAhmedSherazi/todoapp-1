abstract class Data{

  static User ?userDetail;
}

class User{
  String? sId;
  String? name;
  String? email;

  User({this.name, this.email, this.sId});

  User.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

}