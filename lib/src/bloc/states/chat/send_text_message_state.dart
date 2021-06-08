import 'package:equatable/equatable.dart';
import 'package:vootech_realchat/src/models/message/message.dart';

abstract class SendTextMessageState extends Equatable {
  final String uuid;

  const SendTextMessageState(this.uuid);

  @override
  List<Object> get props => [uuid];
}

class SendTextMessageUninitialized extends SendTextMessageState {
  final String uuid;

  SendTextMessageUninitialized(this.uuid) : super(uuid);

  @override
  List<Object> get props => [uuid];

  @override
  String toString() => 'SendTextMessageUninitialized';
}

class SendTextMessageStarted extends SendTextMessageState {
  final String uuid;

  SendTextMessageStarted(this.uuid) : super(uuid);

  @override
  List<Object> get props => [uuid];

  @override
  String toString() => 'SendTextMessageStarted';
}

class SendTextMessageError extends SendTextMessageState {
  final Exception exception;
  final String uuid;

  const SendTextMessageError(this.exception, this.uuid) : super(uuid);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'SendTextMessageError';
}

class SendTextMessageFinished extends SendTextMessageState {
  final MessageModel result;
  final String uuid;

  const SendTextMessageFinished({this.result, this.uuid}) : super(uuid);

  @override
  List<Object> get props => [result, uuid];

  @override
  String toString() => 'SendTextMessageFinished';
}
