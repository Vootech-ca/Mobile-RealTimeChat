import 'package:vootech_realchat/src/models/message/received_message.dart';
import 'package:vootech_realchat/src/models/message/sent_message.dart';

class MessagesResultModel {
  List<ReceivedMessage> receivedMessages;
  List<SentMessage> sentMessages;

  MessagesResultModel({this.receivedMessages, this.sentMessages});

  factory MessagesResultModel.fromJson(Map<String, dynamic> json) {
    return MessagesResultModel(
      receivedMessages: json['receivedMessages'] != null ? (json['receivedMessages'] as List).map((i) => ReceivedMessage.fromJson(i)).toList() : null,
      sentMessages: json['sentMessages'] != null ? (json['sentMessages'] as List).map((i) => SentMessage.fromJson(i)).toList() : null,
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
