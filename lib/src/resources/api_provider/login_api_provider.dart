import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vootech_realchat/core/app_config.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/acces_token_Result_model.dart';

class LoginApiProvider{
  http.Client client;

  LoginApiProvider({http.Client client})
  { this.client = client ?? getIt.get<http.Client>();
  }

  Future<AccessTokenResult> loginAsync(String email, String password) async {
    var url = "${AppConfig.baseUrl}/api/user/login";
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    final response = await client.post(
      url,
      body: json.encode(body),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    return AccessTokenResult.fromJson(json.decode(response.body));

  }
}
