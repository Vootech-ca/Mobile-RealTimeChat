import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/blocs/chat/messages_by_email_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/chat_event.dart';
import 'package:vootech_realchat/src/bloc/states/chat/messages_by_email_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/models/chat_user_model.dart';
import 'package:vootech_realchat/src/models/message/message_by_email_payload_model.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/ui/pages/chat/chat_detail_page.dart';
import 'package:vootech_realchat/src/ui/pages/users/users_list_page.dart';
import 'package:vootech_realchat/src/ui/widgets/busy_indicator.dart';
import 'package:vootech_realchat/src/ui/widgets/card/home_card.dart';
import 'package:vootech_realchat/src/ui/widgets/exception_view.dart';
import 'package:vootech_realchat/src/ui/widgets/network_sensetive.dart';
import 'package:vootech_realchat/src/ui/widgets/ping_item_widget.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;
  var _scrollController = new ScrollController();
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  MessagesByEmailBloc _messagesBloc;
  LocalStorageService _storageService;

  List<MessageModel> chats = [];

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _messagesBloc = getIt<MessagesByEmailBloc>();
    super.initState();
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      _storageService = await LocalStorageService.getInstance();
      if (_storageService.currentUser != null) {
        _messagesBloc.add(FetchAllMessagesByEmail(model: MessageByEmailPayloadModel(msgFrom: _storageService.currentUser.user.email), accessToken: _storageService.currentUser.token));
      } else {
        _messagesBloc.add(FetchAllMessagesByEmail(model: MessageByEmailPayloadModel(msgFrom: "hello212.you5@hi5.com"), accessToken: ""));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  @override
  void dispose() {
    _messagesBloc.close();
    if (animationController != null) {
      animationController.dispose();
    }
    super.dispose();
  }

  Future<Null> _refresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Timer(new Duration(milliseconds: 500), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // here the desired height
        child: AppBar(
          elevation: 1,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      PingItemWidget(name: "name"),
                      PingItemWidget(name: "name"),
                      PingItemWidget(name: "name"),
                    ],
                  )),
            ),
          ),
          toolbarHeight: 100,
          backgroundColor: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                  ],
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ];
                      },
                      body: NetworkSensitive(
                        callback: () async {
                          await _refresh();
                        },
                        child: Container(
                          color: Colors.white,
                          child: RefreshIndicator(
                            key: _refreshIndicatorKey,
                            onRefresh: _refresh,
                            child: BlocListener(
                              bloc: _messagesBloc,
                              listener: (context, state) {
                                if (state is MessagesByEmailLoaded) {
                                  chats.addAll(state.messages.sentMessages);
                                  chats.addAll(state.messages.receivedMessages);
                                }
                              },
                              child: BlocBuilder(
                                bloc: _messagesBloc,
                                builder: (context, state) {
                                  if (state is MessagesByEmailUninitialized || state is MessagesByEmailLoading) {
                                    return Center(
                                      child: BusyIndicator(),
                                    );
                                  }
                                  if (state is MessagesByEmailError) {
                                    return ExceptionView(state.exception);
                                  }
                                  if (state is MessagesByEmailLoaded) {
                                    return ListView.builder(
                                      padding: EdgeInsets.all(8.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: chats.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var chat = chats[index];
                                        var count = chats.length;
                                        var animation = Tween(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                            parent: animationController,
                                            curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                                          ),
                                        );
                                        animationController.forward();
                                        return HomeCard(
                                          animationController: animationController,
                                          animation: animation,
                                          name: chat.toName ?? "",
                                          data: chat.message ?? "",
                                          time: chat.createdAt ?? "",
                                          number: "0",
                                          onTap: () {
                                            var currentUser = _storageService.currentUser.user;
                                            var contact = ChatUserModel(name: chat.toName, email: chat.msgTo);
                                            var accessToken = _storageService.currentUser.token;
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage(currentUser: currentUser, contact: contact, accessToken: accessToken,)));
                                          },
                                        );
                                      },
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UsersListPage()));
            },
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Search...", style: TextStyle(color: AppColors.hintFontColor, fontSize: 12)),
                )),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.search, size: 24, color: AppColors.hintFontColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
