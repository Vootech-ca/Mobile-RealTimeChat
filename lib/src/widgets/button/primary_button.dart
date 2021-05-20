import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final double height;
  final VoidCallback onPressed;

  PrimaryButton({@required this.child, this.onPressed, this.height = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        onTap: () {
          onPressed();
        },
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    AppColors.primaryColor,
    AppColors.secondaryColor
  ]),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor,
                offset: Offset(0, 5),
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Expanded(child: child),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}