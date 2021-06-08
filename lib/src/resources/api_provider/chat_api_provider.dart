import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vootech_realchat/core/app_config.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/infrastracture/error_handling/error_handling_helper.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/models/message/message_by_email_payload_model.dart';
import 'package:vootech_realchat/src/models/message/messages_result_model.dart';

class ChatApiProvider {
  http.Client client;

  ChatApiProvider({http.Client client}) {
    this.client = client ?? getIt.get<http.Client>();
  }

  Future<MessagesResultModel> fetchAllMessagesByEmail(MessageByEmailPayloadModel model, String accessToken) async {
    var url = "${AppConfig.baseUrl}/messages/by-email";
    http.Response response = await client.post(
      url,
      body: json.encode(model.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "auth-token": accessToken,
      },
    );
    ErrorHandlingHelper.ensureSuccessResponse(response);
    return MessagesResultModel.fromJson(json.decode(response.body));
  }

  Future<MessageModel> sendTextMessageAsync(MessageModel model, String accessToken) async {
    var url = "${AppConfig.baseUrl}/messages/send";
    http.Response response = await client.post(
      url,
      body: json.encode(model.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "auth-token": accessToken,
      },
    );
    ErrorHandlingHelper.ensureSuccessResponse(response);
    return MessageModel.fromJson(json.decode(response.body));
  }
}
