import 'package:vootech_realchat/src/models/message/message.dart';

class MessagesResultModel {
  List<MessageModel> receivedMessages;
  List<MessageModel> sentMessages;

  MessagesResultModel({this.receivedMessages, this.sentMessages});

  factory MessagesResultModel.fromJson(Map<String, dynamic> json) {
    return MessagesResultModel(
      receivedMessages: json['receivedMessages'] != null ? (json['receivedMessages'] as List).map((i) => MessageModel.fromJson(i)).toList() : null,
      sentMessages: json['sentMessages'] != null ? (json['sentMessages'] as List).map((i) => MessageModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receivedMessages != null) {
      data['receivedMessages'] = this.receivedMessages.map((v) => v.toJson()).toList();
    }
    if (this.sentMessages != null) {
      data['sentMessages'] = this.sentMessages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
