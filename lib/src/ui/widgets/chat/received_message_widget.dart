import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/ui/widgets/circle_avatar.dart';

class ReceivedMessagesWidget extends StatelessWidget {
  final MessageModel message;

  const ReceivedMessagesWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyCircleAvatar(imgUrl: "${message.image}"),
          SizedBox(width: 4),
          Container(
            margin: EdgeInsets.only(top: 16),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(message.message, style: Theme.of(context).textTheme.body1.apply(color: Colors.black87)),
                Text(message.createdAt, style: TextStyle(fontSize: 8, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
