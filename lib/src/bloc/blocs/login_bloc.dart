
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/login_event.dart';
import 'package:vootech_realchat/src/bloc/states/login_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/resources/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository _repository;

  LoginBloc({LoginRepository repository}) : super(LoginUninitialized()) {
    this._repository = repository ?? getIt.get<LoginRepository>();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      try {
        yield LoginLoading();
        var result = await _repository.loginAsync(event.email, event.password);
        yield LoginSuccess(result: result);
      } catch (ex) {
        yield LoginError(ex);
      }
    }
  }
}
