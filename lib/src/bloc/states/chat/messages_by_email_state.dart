import 'package:equatable/equatable.dart';
import 'package:vootech_realchat/src/models/message/messages_result_model.dart';

abstract class MessagesByEmailState extends Equatable {
  const MessagesByEmailState();

  @override
  List<Object> get props => [];
}

class MessagesByEmailUninitialized extends MessagesByEmailState {
  @override
  String toString() => 'Messages By Email Uninitialized';
}

class MessagesByEmailLoading extends MessagesByEmailState {
  @override
  String toString() => 'Messages By Email Loading';
}

class MessagesByEmailError extends MessagesByEmailState {
  final Exception exception;

  const MessagesByEmailError(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'Messages By Email Error';
}

class MessagesByEmailLoaded extends MessagesByEmailState {
  final MessagesResultModel messages;

  const MessagesByEmailLoaded({this.messages});

  @override
  List<Object> get props => [messages];

  @override
  String toString() => 'Messages By Email loaded';
}
