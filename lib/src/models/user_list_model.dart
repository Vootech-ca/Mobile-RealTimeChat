class UserListModel {
  String _id;
  String _name;
  String _email;

  String get id => _id;

  String get name => _name;

  String get email => _email;

  UserListModel({String id, String name, String email}) {
    _id = id;
    _name = name;
    _email = email;
  }

  UserListModel.fromJson(dynamic json) {
    _id = json["_id"];
    _name = json["name"];
    _email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    return map;
  }
}
