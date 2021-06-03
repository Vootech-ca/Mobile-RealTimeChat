import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class UserItemCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  UserItemCard({
    @required this.name,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 3, color: AppColors.secondaryColor),
                  ),
                ),
                Text(name, style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
