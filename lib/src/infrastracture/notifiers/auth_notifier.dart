import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/models/acces_token_Result_model.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';

class AuthNotifier extends ChangeNotifier{
  AccessTokenResult token;

  AuthNotifier(){
    token = null;
  }

  Future<AccessTokenResult> initialAuthData() async {
    var storageService = await LocalStorageService.getInstance();
    this.token = storageService.currentUser;
    return Future.value(token);
  }

  Future<User> getCurrentUserAsync() async {
    return Future.value(token.user);
  }

  Future<String> getAccessTokenAsync() async {
    return Future.value(token.token);
  }

  void loginUser(AccessTokenResult tokenResult) {
    this.token = tokenResult;
    notifyListeners();
  }
}