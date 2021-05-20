import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_assets.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Card(
          child: Container(
            height: height/2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(AppAssets.onboardThreeImage),
          ),
        )

      ],
    );
  }
}