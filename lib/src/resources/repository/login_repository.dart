import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/access_token_result_model.dart';
import 'package:vootech_realchat/src/resources/api_provider/login_api_provider.dart';

class LoginRepository {
  LoginApiProvider loginApiProvider;

  LoginRepository({LoginApiProvider loginApiProvider}) {
    this.loginApiProvider = loginApiProvider ?? getIt.get<LoginApiProvider>();
  }

  Future<AccessTokenResult> loginAsync(String email, String password) => loginApiProvider.loginAsync(email, password);
}
