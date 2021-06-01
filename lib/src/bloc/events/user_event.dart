import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchAllUsers extends UserEvent {
  final String accessToken;


  const FetchAllUsers({@required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}