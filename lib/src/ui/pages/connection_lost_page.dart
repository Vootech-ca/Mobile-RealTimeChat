import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/ui/widgets/button/primary_button.dart';

class ConnectionLostPage extends StatefulWidget {
  const ConnectionLostPage({Key key}) : super(key: key);

  @override
  _ConnectionLostPageState createState() => _ConnectionLostPageState();
}

class _ConnectionLostPageState extends State<ConnectionLostPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change password"),
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height / 4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(AppAssets.connectionLess),
            ),
            SizedBox(height: 8),
            Text("Connection Lost!", textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("No internet connection, check the connection to your network", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.hintFontColor)),
            ),
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(
                onPressed: () {},
                title: "Try Again",
                height: 54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
