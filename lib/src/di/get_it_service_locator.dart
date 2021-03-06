import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vootech_realchat/src/bloc/blocs/chat/messages_by_email_bloc.dart';
import 'package:vootech_realchat/src/bloc/blocs/chat/send_text_message_bloc.dart';
import 'package:vootech_realchat/src/bloc/blocs/login_bloc.dart';
import 'package:vootech_realchat/src/bloc/blocs/users_list_bloc.dart';
import 'package:vootech_realchat/src/resources/api_provider/chat_api_provider.dart';
import 'package:vootech_realchat/src/resources/api_provider/login_api_provider.dart';
import 'package:vootech_realchat/src/resources/api_provider/user_api_provider.dart';
import 'package:vootech_realchat/src/resources/repository/chat_repository.dart';
import 'package:vootech_realchat/src/resources/repository/login_repository.dart';
import 'package:vootech_realchat/src/resources/repository/user_repository.dart';

GetIt getIt = GetIt.I;

void setupLocator() {
  // Singleton
  getIt.registerSingleton(http.Client());
  getIt.registerSingleton(LoginApiProvider());
  getIt.registerSingleton(UserApiProvider());
  getIt.registerSingleton(ChatApiProvider());
  getIt.registerSingleton(LoginRepository());
  getIt.registerSingleton(UserRepository());
  getIt.registerSingleton(ChatRepository());

  // Factory
  getIt.registerFactory<LoginBloc>(() => LoginBloc());
  getIt.registerFactory<UsersListBloc>(() => UsersListBloc());
  getIt.registerFactory<MessagesByEmailBloc>(() => MessagesByEmailBloc());
  getIt.registerFactory<SendTextMessageBloc>(() => SendTextMessageBloc());
}
