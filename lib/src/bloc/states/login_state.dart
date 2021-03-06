import 'package:equatable/equatable.dart';
import 'package:vootech_realchat/src/models/access_token_result_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginUninitialized extends LoginState {
  @override
  String toString() => 'Login Uninitialized';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'Login Loading';
}

class LoginError extends LoginState {
  final Exception exception;

  const LoginError(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'Login Error';
}

class LoginSuccess extends LoginState {
  final AccessTokenResult result;

  const LoginSuccess({this.result});

  LoginSuccess copyWith({AccessTokenResult result}) {
    return LoginSuccess(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'Login Success';
}