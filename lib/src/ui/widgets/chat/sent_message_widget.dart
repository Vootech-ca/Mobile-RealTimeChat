import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/states/chat/send_text_message_state.dart';
import 'package:vootech_realchat/src/models/message/message.dart';

class SentMessageWidget extends StatelessWidget {
  final SendTextMessageState sendState;
  final MessageModel message;

  const SentMessageWidget({
    Key key,
    this.sendState,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(message.createdAt, style: Theme.of(context).textTheme.body2.apply(color: Colors.grey)),
          SizedBox(width: 15),
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Text(
              (sendState is SendTextMessageStarted && sendState.uuid == message.uuid) ? "Sending" : message.message,
              style: Theme.of(context).textTheme.body2.apply(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
