import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/pages/onboard/onboard_page.dart';
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
        body: Center(
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardPage()));
    }
  }
}
