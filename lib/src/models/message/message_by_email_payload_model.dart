import 'package:json_annotation/json_annotation.dart';

class MessageByEmailPayloadModel {
  @JsonKey(name: "_id")
  String id;
  String images;
  String message;
  String messageStatus;
  String msgFrom;
  String msgTo;
  String toName;

  MessageByEmailPayloadModel({
    this.id,
    this.images,
    this.message,
    this.messageStatus,
    this.msgFrom,
    this.msgTo,
    this.toName,
  });

  factory MessageByEmailPayloadModel.fromJson(Map<String, dynamic> json) {
    return MessageByEmailPayloadModel(
      id: json['_id'],
      images: json['images'],
      message: json['message'],
      messageStatus: json['messageStatus'],
      msgFrom: json['msgFrom'],
      msgTo: json['msgTo'],
      toName: json['toName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['images'] = this.images;
    data['message'] = this.message;
    data['messageStatus'] = this.messageStatus;
    data['msgFrom'] = this.msgFrom;
    data['msgTo'] = this.msgTo;
    data['toName'] = this.toName;
    return data;
  }
}
