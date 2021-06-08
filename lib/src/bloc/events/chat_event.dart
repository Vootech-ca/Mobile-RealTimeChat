import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/models/message/message_by_email_payload_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMessagesByEmail extends ChatEvent {
  final MessageByEmailPayloadModel model;
  final String accessToken;

  const FetchAllMessagesByEmail({
    @required this.model,
    @required this.accessToken,
  });

  @override
  List<Object> get props => [model, accessToken];
}

class NewMessageAdded extends ChatEvent {
  final MessageModel message;

  NewMessageAdded({@required this.message});

  @override
  List<Object> get props => [
    message
  ];

  @override
  String toString() => 'New message added';
}

class SendTextMessage extends ChatEvent {
  final MessageModel message;
  final String accessToken;
  final String uuid;

  const SendTextMessage({
    @required this.message,
    @required this.accessToken,
    @required this.uuid,
  });

  @override
  List<Object> get props => [message, accessToken, uuid];
}
