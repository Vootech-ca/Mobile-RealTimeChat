import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double height;
  final VoidCallback onPressed;
  final Color color1;
  final Color color2;

  PrimaryButton({
    @required this.title,
    @required this.onPressed,
    this.height = 48,
    this.color1 = AppColors.primaryColor,
    this.color2 = AppColors.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {
          onPressed();
        },
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color2]),
            borderRadius: BorderRadius.all(Radius.circular(20)),

          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
