import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/my_app.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthNotifier(), lazy: false),
      ],
      child: MyApp(),
    ));
  });
}
