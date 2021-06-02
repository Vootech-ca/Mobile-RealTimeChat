import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/chat_app_bar.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/write_message.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: ChatAppBar(),
          ),
        ),
        body: WriteMessage(),
    );
  }
}
