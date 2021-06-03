import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/src/enums/connectivity_status.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';
import 'package:vootech_realchat/src/infrastracture/services/connectivity_status.dart';
import 'package:vootech_realchat/src/ui/pages/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) => ConnectivityService().connectionStatusController.stream,
      child: Consumer<AuthNotifier>(
        builder: (context, authNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
