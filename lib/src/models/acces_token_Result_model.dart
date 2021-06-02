/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGFhNGJkOGE2ZmRiZjAwMDQ1NzY1YjIiLCJpYXQiOjE2MjE5NTQ0NTJ9.ceb7yNIVunfXDpRbyFLszUO_ikZMd9al_emb1GwEci4"
/// user : {"isActive":false,"_id":"60aa4bd8a6fdbf00045765b2","name":"farzad","email":"farzad.f@gmail.com","password":"$2a$10$asKD6CRUXuImoVHoJEeamuNLlnIoMkglpvCPZXY.aXXEdl.dcOZ9i","regDate":"2021-05-23T12:34:32.974Z","__v":0}

class AccessTokenResult {
  String _token;
  User _user;

  String get token => _token;
  User get user => _user;

  AccessTokenResult({
      String token, 
      User user}){
    _token = token;
    _user = user;
}

  AccessTokenResult.fromJson(dynamic json) {
    _token = json["token"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = _token;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }

}

/// isActive : false
/// _id : "60aa4bd8a6fdbf00045765b2"
/// name : "farzad"
/// email : "farzad.f@gmail.com"
/// password : "$2a$10$asKD6CRUXuImoVHoJEeamuNLlnIoMkglpvCPZXY.aXXEdl.dcOZ9i"
/// regDate : "2021-05-23T12:34:32.974Z"
/// __v : 0

class User {
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

  User({
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

  User.fromJson(dynamic json) {
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