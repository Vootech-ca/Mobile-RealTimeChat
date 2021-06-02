import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class HomeCard extends StatelessWidget {
  final String name;
  final String time;
  final String data;
  final String number;

  HomeCard({@required this.name, @required this.time, @required this.data, @required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: AppColors.secondaryColor),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Text(name, style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 18))),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(time, style: TextStyle(color: AppColors.hintFontColor, fontSize: 13, letterSpacing: .3)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: Text(data, style: TextStyle(fontSize: 14, letterSpacing: .3))),
                    Container(
                      child: Center(child: Text(number, style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: .3))),
                      width: 28,
                      height: 16,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3, color: AppColors.secondaryColor),
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
