import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/user_list_model.dart';
import 'package:vootech_realchat/src/resources/api_provider/user_api_provider.dart';

class UserRepository {
  UserApiProvider apiProvider;

  UserRepository({UserApiProvider userApiProvider}) {
    this.apiProvider = userApiProvider ?? getIt.get<UserApiProvider>();
  }

  Future<List<UserListModel>> fetchAllMessagesUsersAsync(String accessToken) => apiProvider.fetchAllMessagesUsersAsync(accessToken);
}
