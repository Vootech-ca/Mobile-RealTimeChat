import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vootech_realchat/core/app_config.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/chat_user_model.dart';

class UserApiProvider {
  http.Client client;

  UserApiProvider({http.Client client}) {
    this.client = client ?? getIt.get<http.Client>();
  }

  Future<List<ChatUserModel>> fetchAllMessagesUsersAsync(String accessToken) async {
    var url = "${AppConfig.baseUrl}/users/all";
    http.Response response = await client.get(
      url,
      headers: {
        "auth-token": "$accessToken",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    var resultJson = json.decode(response.body);
    return resultJson != null ? (resultJson as List).map((i) => ChatUserModel.fromJson(i)).toList() : null;
  }
}
