import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/my_app.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';

void main() {
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthNotifier(), lazy: false),
    ],
    child: MyApp(),
  ));
}
