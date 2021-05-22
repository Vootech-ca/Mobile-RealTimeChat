import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height/2,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(AppAssets.onboardTwoImage , fit: BoxFit.cover),
        ),
        SizedBox(height: 48,),
        Text(
          "Send photo and video",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit,  ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.hintFontColor,
            ),
          ),
        )
      ],
    );
  }
}
