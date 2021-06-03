import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/blocs/users_list_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/user_event.dart';
import 'package:vootech_realchat/src/bloc/states/user_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';
import 'package:vootech_realchat/src/models/user_list_model.dart';
import 'package:vootech_realchat/src/ui/pages/chat/chat_detail_page.dart';
import 'package:vootech_realchat/src/ui/widgets/busy_indicator.dart';
import 'package:vootech_realchat/src/ui/widgets/button/circle_icon_button.dart';
import 'package:vootech_realchat/src/ui/widgets/card/user_item_card.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key key}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final TextEditingController _controller = new TextEditingController();
  UsersListBloc _usersListBloc;
  AuthNotifier _authService;

  List<UserListModel> _allUsers = [];

  List<UserListModel> _filteredUsers = [];

  @override
  void initState() {
    _usersListBloc = getIt<UsersListBloc>();
    super.initState();
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      var storageService = await LocalStorageService.getInstance();
      if (storageService.currentUser != null) {
        _usersListBloc.add(FetchAllUsers(accessToken: storageService.currentUser.token));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  @override
  void dispose() {
    _usersListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authService = Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Search Users...",
                ),
                style: TextStyle(fontSize: 14),
                onChanged: (text) {
                  if (text.length > 0) {
                    var filtered = _filteredUsers.where((element) => element.name.toLowerCase().contains(text.toLowerCase()));
                    setState(() {
                      _filteredUsers = filtered.toList();
                    });
                  } else {
                    setState(() {
                      _filteredUsers = _allUsers;
                    });
                  }
                },
              ),
            ),
            _controller.text.length > 0
                ? CircleIconButton(
                    size: 24,
                    iconSize: 20,
                    color: Colors.grey,
                    icon: Icons.close,
                    callback: () {
                      setState(() {
                        _controller.text = "";
                        setState(() {
                          _filteredUsers = _allUsers;
                        });
                      });
                    },
                  )
                : SizedBox()
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener(
        bloc: _usersListBloc,
        listener: (context, state) {
          if (state is UsersListLoaded) {
            setState(() {
              _allUsers = state.users;
              _filteredUsers = state.users;
            });
          }
        },
        child: BlocBuilder(
          bloc: _usersListBloc,
          builder: (context, state) {
            if (state is UsersListLoading) {
              return Center(
                  child: BusyIndicator(
                color: AppColors.secondaryColor,
                size: 32,
              ));
            }
            if (state is UsersListLoaded) {
              if (_filteredUsers.isEmpty) {
                return Center(child: Text("Not any user found"));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var user = _filteredUsers.elementAt(index);
                  return UserItemCard(
                    name: user.name,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage()));
                    },
                  );
                },
                itemCount: _filteredUsers.length,
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
