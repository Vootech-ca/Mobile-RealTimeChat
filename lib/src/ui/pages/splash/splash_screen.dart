import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';
import 'package:vootech_realchat/src/ui/pages/home/home_page.dart';
import 'package:vootech_realchat/src/ui/pages/login/login_page.dart';
import 'package:vootech_realchat/src/ui/pages/onboard/onboard_page.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorageService _storageService;

  @override
  void initState() {
    super.initState();
    startTimer();
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      _storageService = await LocalStorageService.getInstance();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<AuthNotifier>(context, listen: false).initialAuthData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              startTimer();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(AppAssets.logo, fit: BoxFit.cover),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Real", style: TextStyle(fontFamily: 'Blkchtry', color: AppColors.secondaryColor, fontSize: 32, fontWeight: FontWeight.bold)),
                              Text("Chat", style: TextStyle(fontFamily: 'Blkchtry', color: AppColors.primaryColor, fontSize: 32, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('copyright @ 2021 - vootech', style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
                    SizedBox(height: 16)
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  startTimer() async {
    debugPrint("Timer started");
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigateToMainPage);
  }

  Future<void> navigateToMainPage() async {
    debugPrint("Timer completed");
    if (_storageService != null) {
      if (_storageService.onBoardScreenSeen) {
        if (_storageService.currentUser == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
