import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/ui/widgets/card/notification_card.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({Key key}) : super(key: key);

  @override
  _NotificationFragmentState createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
         NotificationCard(name: "name", time: "12:15", data: "Hello farzad"),
         NotificationCard(name: "name", time: "12:15", data: "How Are you"),
         NotificationCard(name: "name", time: "08:45", data: "Are you here"),
         NotificationCard(name: "name", time: "11:00", data: "data"),
        ],
      ),
    );
  }
}
