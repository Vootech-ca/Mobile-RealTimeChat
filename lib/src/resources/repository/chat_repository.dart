import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/message/message_by_email_payload_model.dart';
import 'package:vootech_realchat/src/models/message/messages_result_model.dart';
import 'package:vootech_realchat/src/resources/api_provider/chat_api_provider.dart';

class ChatRepository {
  ChatApiProvider apiProvider;

  ChatRepository({ChatApiProvider apiProvider}) {
    this.apiProvider = apiProvider ?? getIt.get<ChatApiProvider>();
  }

  Future<MessagesResultModel> fetchAllMessagesByEmail(MessageByEmailPayloadModel model) => apiProvider.fetchAllMessagesByEmail(model);
}
