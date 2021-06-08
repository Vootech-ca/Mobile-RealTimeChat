import 'package:bloc/bloc.dart';
import 'package:vootech_realchat/src/bloc/events/chat_event.dart';
import 'package:vootech_realchat/src/bloc/states/chat/send_text_message_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/resources/repository/chat_repository.dart';

class SendTextMessageBloc extends Bloc<ChatEvent, SendTextMessageState> {
  ChatRepository _repository;

  SendTextMessageBloc({ChatRepository repository}) : super(SendTextMessageUninitialized("")) {
    this._repository = repository ?? getIt.get<ChatRepository>();
  }

  @override
  Stream<SendTextMessageState> mapEventToState(ChatEvent event) async* {
    if (event is SendTextMessage) {
      try {
        yield SendTextMessageUninitialized(event.uuid);
        yield SendTextMessageStarted(event.uuid);
        var result = await _repository.sendTextMessageAsync(event.message, event.accessToken);
        yield SendTextMessageFinished(uuid: event.uuid, result: result);
      } catch (ex) {
        yield SendTextMessageError(ex, event.uuid);
      }
    }
  }
}
