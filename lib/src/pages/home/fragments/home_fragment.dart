import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/widgets/card/home_card.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          HomeCard(name: "name", time: "time", data: "data"),
          HomeCard(name: "name", time: "time", data: "data"),
          HomeCard(name: "name", time: "time", data: "data"),
          HomeCard(name: "name", time: "time", data: "data"),
        ],
      ),
    );
  }
}
