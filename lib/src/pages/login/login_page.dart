import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/pages/login/change_password_page.dart';
import 'package:vootech_realchat/src/widgets/button/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Image.asset(AppAssets.loginIcon),
            ),

            Text("Welcome",
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
            SizedBox(height: 32),
            Text("Sing in to continue",
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.hintFontColor)),
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
                  labelText: 'UserName/Email',
                ),
                validator: (value) {
                  if(value.isEmpty){
                    return "Username is required";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  counterText: "",
                  border: const OutlineInputBorder(
                    borderSide: const BorderSide(color:  AppColors.hintFontColor,  width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if(value.isEmpty){
                    return "Username is required";
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
                          builder: (context) => ChangePasswordPage()));
                },
                title: "Sign in",
                height: 48,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 70, left: 30, right: 30),
              child: Center(
                child: RichText(
                  text: TextSpan(

                      children: <TextSpan>[
                        TextSpan(
                            text: 'Forgot Password?',
                            style: TextStyle(
                                color: AppColors.errorColor,
                                fontSize: 14))
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
