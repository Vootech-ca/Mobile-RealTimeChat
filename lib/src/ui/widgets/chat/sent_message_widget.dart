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
    var isSending = (sendState is SendTextMessageStarted && sendState.uuid == message.uuid);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
              color: AppColors.lightSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 48),
                  child: Text(message.message, style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.white)),
                ),
                SizedBox(height: 5),
                isSending ? Icon(Icons.access_time, size: 16, color: Colors.white) : Text(message.createdAt, style: Theme.of(context).textTheme.caption.apply(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
