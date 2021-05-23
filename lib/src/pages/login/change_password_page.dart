import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/pages/connection_lost_page.dart';
import 'package:vootech_realchat/src/widgets/button/primary_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height / 4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(AppAssets.lock),
            ),

            Text("Troble Logging In?",
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Enter your email or phone and we'll send you a link to get back into your account.",
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.hintFontColor)),
            ),
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  counterText: "",
                  border: const OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.hintFontColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  labelText: 'Email/Phone',
                ),
                validator: (value) {
                  if(value.isEmpty){
                    return "Email/Phone is required";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(

                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConnectionLostPage()));

                },
                title: "Send Login Link",
                height: 48,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
