import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/states/chat/send_text_message_state.dart';
import 'package:vootech_realchat/src/models/message/message.dart';

class SentImageMessageWidget extends StatelessWidget {
  final SendTextMessageState sendState;
  final MessageModel message;
  final VoidCallback callback;

  const SentImageMessageWidget({
    Key key,
    this.sendState,
    this.message,
    this.callback,
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
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6, maxHeight: 150),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: AppColors.lightSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Material(
                color: AppColors.lightSecondaryColor,
                child: InkWell(
                  child: Container(child: _buildMessage(context)),
                  onTap: () => callback(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (sendState is SendTextMessageStarted && sendState.uuid == message.uuid) {
      return Padding(
        padding: const EdgeInsets.all(11.0),
        child: Text("Sending", style: TextStyle(color: Colors.white)),
      );
    } else {
      if (message.message.startsWith("/storage")) {
        return _buildLocalImage();
      } else {
        return _buildNetworkImage();
      }
    }
  }

  Widget _buildLocalImage() {
    return Image.file(message.file);
  }

  Widget _buildNetworkImage() {
    var urlSegments = message.message.split(",");
    var mainUrl = urlSegments[1];
    return CachedNetworkImage(imageUrl: "$mainUrl");
  }
}
