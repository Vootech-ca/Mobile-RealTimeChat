import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/chat_event.dart';
import 'package:vootech_realchat/src/bloc/states/chat/messages_by_email_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/resources/repository/chat_repository.dart';

class MessagesByEmailBloc extends Bloc<ChatEvent, MessagesByEmailState> {
  ChatRepository _repository;

  MessagesByEmailBloc({ChatRepository repository}) : super(MessagesByEmailUninitialized()) {
    this._repository = repository ?? getIt.get<ChatRepository>();
  }

  @override
  Stream<MessagesByEmailState> mapEventToState(ChatEvent event) async* {
    if (event is FetchAllMessagesByEmail) {
      try {
        yield MessagesByEmailLoading();
        var result = await _repository.fetchAllMessagesByEmail(event.model, event.accessToken);
        yield MessagesByEmailLoaded(messages: result);
      } catch (ex) {
        yield MessagesByEmailError(ex);
      }
    } else if (event is NewMessageAdded) {
      yield* _mapAddNewMessageState(event);
    }
  }

  Stream<MessagesByEmailState> _mapAddNewMessageState(NewMessageAdded event) async* {
    if (state is MessagesByEmailLoaded) {
      try {
        var chatMessages = (state as MessagesByEmailLoaded).messages;
        final List<MessageModel> updatedList = List.from(chatMessages.sentMessages)..add(event.message);
        chatMessages.sentMessages = updatedList;
        yield MessagesByEmailUninitialized();
        yield MessagesByEmailLoaded(messages: chatMessages);
      } catch (ex) {
        print(ex);
      }
    }
  }
}
