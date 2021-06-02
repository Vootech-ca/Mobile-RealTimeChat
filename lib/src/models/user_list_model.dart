class UserListModel {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  UserListModel({
      String id, 
      String name,}){
    _id = id;
    _name = name;
}

  UserListModel.fromJson(dynamic json) {
    _id = json["_id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["name"] = _name;
    return map;
  }
}