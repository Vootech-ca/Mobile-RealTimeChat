import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/pages/home/home_page.dart';
import 'package:vootech_realchat/src/pages/login/login_page.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}
