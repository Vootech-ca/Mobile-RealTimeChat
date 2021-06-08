import 'package:equatable/equatable.dart';
import 'package:vootech_realchat/src/models/chat_user_model.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class UsersListUninitialized extends UsersListState {
  @override
  String toString() => 'Users List Uninitialized';
}

class UsersListLoading extends UsersListState {
  @override
  String toString() => 'Users List Loading';
}


class UsersListError extends UsersListState {
  final Exception exception;

  const UsersListError(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'Users List Error';
}

class UsersListLoaded extends UsersListState {
  final List<ChatUserModel> users;

  const UsersListLoaded({this.users});

  @override
  List<Object> get props => [ users];

  @override
  String toString() => 'Users list loaded: ${users.length}';
}


