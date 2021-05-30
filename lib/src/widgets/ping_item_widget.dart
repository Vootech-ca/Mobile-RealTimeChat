import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class PingItemWidget extends StatelessWidget {
  final String name;
  PingItemWidget({@required this.name,});


  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 80,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: AppColors.secondaryColor),

              ),
            ),
            Text(name, style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 10)),

          ],
        ),
      ),
    );
  }
}
