import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:vootech_realchat/src/enums/chat_enums.dart';

class MessageModel {
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "_id")
  String id;
  String createdAt;
  String image;
  String message;
  bool messageStatus;
  String msgFrom;
  String msgTo;
  String toName;
  MessageType type;
  String uuid;
  File file;
  SentOrReceived sentOrReceived;

  MessageModel({
    this.v,
    this.id,
    this.createdAt,
    this.image,
    this.message,
    this.messageStatus,
    this.msgFrom,
    this.msgTo,
    this.toName,
    this.type,
    this.uuid,
    this.file,
    this.sentOrReceived,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      v: json['__v'],
      id: json['_id'],
      createdAt: json['createdAt'],
      image: json['image'],
      message: json['message'],
      messageStatus: json['messageStatus'],
      msgFrom: json['msgFrom'],
      msgTo: json['msgTo'],
      toName: json['toName'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['message'] = this.message;
    data['messageStatus'] = this.messageStatus;
    data['msgFrom'] = this.msgFrom;
    data['msgTo'] = this.msgTo;
    data['toName'] = this.toName;
    data['type'] = this.type;
    return data;
  }
}
