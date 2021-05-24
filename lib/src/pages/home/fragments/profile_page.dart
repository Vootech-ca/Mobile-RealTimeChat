import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/widgets/button/primary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    //avatar
                    Ink(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AppAssets.profile),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Align(
                      alignment: Alignment(1, 1),
                      child: MaterialButton(
                        minWidth: 0,
                        child: Icon(Icons.photo_camera_outlined),
                        onPressed: () {},
                        textColor: Colors.white,
                        color: AppColors.secondaryColor.withOpacity(0.5),

                        elevation: 0,
                        shape: CircleBorder(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Natalie",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(
                onPressed: () {},
                title: "Change Password",
                height: 54,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(
                onPressed: () {},
                title: "Sign out",
                height: 54,
                color1: AppColors.errorColor,
                color2: AppColors.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
