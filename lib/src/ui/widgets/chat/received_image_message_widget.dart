import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/ui/widgets/circle_avatar.dart';

class ReceivedImageMessagesWidget extends StatelessWidget {
  final MessageModel message;
  final VoidCallback callback;

  const ReceivedImageMessagesWidget({Key key, @required this.message, this.callback}) : super(key: key);

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
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8, maxHeight: 150),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: AppColors.lightPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: AppColors.lightPrimaryColor,
                      child: InkWell(
                        child: _buildMessage(),
                        onTap: () => callback(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(message.createdAt, style: TextStyle(fontSize: 8, color: Colors.grey)),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildMessage() {
    if (message.message.startsWith("/storage")) {
      return _buildLocalImage();
    } else {
      return _buildNetworkImage();
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
