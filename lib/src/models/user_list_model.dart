/// isActive : false
/// _id : "60aecbac33bbdb11045539c1"
/// name : "Dev Bazh0"
/// email : "bazh0.120@gmail.com"
/// password : "$2a$10$mFAa1J7.P/aqYjlc6dCACO9C4e/HvGL9l52lWXy1yHnIg4mX/.VKe"
/// regDate : "2021-05-26T22:29:00.976Z"
/// __v : 0

class UserListModel {
  bool _isActive;
  String _id;
  String _name;
  String _email;
  String _password;
  String _regDate;
  int _v;

  bool get isActive => _isActive;
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get regDate => _regDate;
  int get v => _v;

  UserListModel({
      bool isActive, 
      String id, 
      String name, 
      String email, 
      String password, 
      String regDate, 
      int v}){
    _isActive = isActive;
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _regDate = regDate;
    _v = v;
}

  UserListModel.fromJson(dynamic json) {
    _isActive = json["isActive"];
    _id = json["_id"];
    _name = json["name"];
    _email = json["email"];
    _password = json["password"];
    _regDate = json["regDate"];
    _v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isActive"] = _isActive;
    map["_id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["password"] = _password;
    map["regDate"] = _regDate;
    map["__v"] = _v;
    return map;
  }

}