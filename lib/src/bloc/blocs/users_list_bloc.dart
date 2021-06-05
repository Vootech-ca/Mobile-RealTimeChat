import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/user_event.dart';
import 'package:vootech_realchat/src/bloc/states/user_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/resources/repository/user_repository.dart';

class UsersListBloc extends Bloc<UserEvent, UsersListState> {
  UserRepository _repository;

  UsersListBloc({UserRepository repository}) : super(UsersListUninitialized()) {
    this._repository = repository ?? getIt.get<UserRepository>();
  }

  @override
  Stream<UsersListState> mapEventToState(UserEvent event) async* {
    if (event is FetchAllUsers) {
      try {
        yield UsersListLoading();
        var result = await _repository.fetchAllMessagesUsersAsync(event.accessToken);
        yield UsersListLoaded(users: result);
      } catch (ex) {
        yield UsersListError(ex);
      }
    }
  }
}