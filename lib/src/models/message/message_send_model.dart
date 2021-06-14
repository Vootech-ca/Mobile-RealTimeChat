class MessageSendModel {
  String message;
  String msgFrom;
  String msgTo;

  MessageSendModel({
    this.message,
    this.msgFrom,
    this.msgTo,
  });

  factory MessageSendModel.fromJson(Map<String, dynamic> json) {
    return MessageSendModel(
      message: json['message'],
      msgFrom: json['msgFrom'],
      msgTo: json['msgTo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['msgFrom'] = this.msgFrom;
    data['msgTo'] = this.msgTo;
    return data;
  }
}
