import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class NotificationCard extends StatelessWidget {

  final String name;
  final String time;
  final String data;

  NotificationCard({@required this.name, @required this.time, @required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8), child: Icon(Icons.notifications, color: AppColors.primaryColor, size: 30)),
            SizedBox(width: 16),
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
                  Text(data, style: TextStyle( fontSize: 14, letterSpacing: .3)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
