import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/blocs/chat/messages_by_email_bloc.dart';
import 'package:vootech_realchat/src/bloc/blocs/chat/send_text_message_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/chat_event.dart';
import 'package:vootech_realchat/src/bloc/states/chat/messages_by_email_state.dart';
import 'package:vootech_realchat/src/bloc/states/chat/send_text_message_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/enums/chat_enums.dart';
import 'package:vootech_realchat/src/infrastracture/notifiers/auth_notifier.dart';
import 'package:vootech_realchat/src/models/access_token_result_model.dart';
import 'package:vootech_realchat/src/models/chat_user_model.dart';
import 'package:vootech_realchat/src/models/message/message.dart';
import 'package:vootech_realchat/src/models/message/message_by_email_payload_model.dart';
import 'package:vootech_realchat/src/models/message/messages_result_model.dart';
import 'package:vootech_realchat/src/ui/widgets/busy_indicator.dart';
import 'package:vootech_realchat/src/ui/widgets/button/circle_icon_button.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/received_image_message_widget.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/received_message_widget.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/sent_image_message_widget.dart';
import 'package:vootech_realchat/src/ui/widgets/chat/sent_message_widget.dart';
import 'package:vootech_realchat/src/ui/widgets/circle_avatar.dart';
import 'package:vootech_realchat/src/ui/widgets/gallery/gallery_photo_item.dart';
import 'package:vootech_realchat/src/ui/widgets/gallery/gallery_photo_viewer_wrapper.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';

class ChatDetailPage extends StatefulWidget {
  final User currentUser;
  final ChatUserModel contact;
  final String accessToken;

  ChatDetailPage({this.currentUser, this.contact, this.accessToken});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _msgScrollController = new ScrollController();
  final _txtMessageController = new TextEditingController();

  MessagesByEmailBloc _consultancyBloc;
  SendTextMessageBloc _sendMessageBloc;
  LocalStorageService _storageService;
  bool _showBottom = false;
  bool _showSendMessage = false;
  var _uuid = Uuid();

  MessagesResultModel _currentChat;

  List<MessageModel> chatMessages = [];

  Random random = new Random();

  @override
  void initState() {
    super.initState();
    _consultancyBloc = getIt<MessagesByEmailBloc>();
    _sendMessageBloc = getIt<SendTextMessageBloc>();
    _currentChat = null;
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      _storageService = await LocalStorageService.getInstance();
      _consultancyBloc.add(FetchAllMessagesByEmail(model: MessageByEmailPayloadModel(msgFrom: _storageService.currentUser.user.email), accessToken: _storageService.currentUser.token));
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  @override
  void dispose() {
    _consultancyBloc.close();
    _sendMessageBloc.close();
    _msgScrollController.dispose();
    _txtMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                    MyCircleAvatar(imgUrl: ""),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.contact.name, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis, maxLines: 1),
                          Text("Online", style: TextStyle(fontSize: 8, color: Colors.grey)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              BlocListener(
                bloc: _consultancyBloc,
                listener: (context, chatState) {
                  if (chatState is MessagesByEmailLoaded) {
                    var messages = chatState.messages;
                    // var mySentMessages = messages.sentMessages.where((m) => m.msgFrom == widget.currentUser.email && m.msgTo == widget.contact.email).toList();
                    var mySentMessages = messages.sentMessages.toList();
                    // var myReceivedMessages = messages.receivedMessages.where((m) => m.msgTo == widget.currentUser.email && m.msgFrom == widget.contact.email).toList();
                    var myReceivedMessages = messages.receivedMessages.toList();
                    for (var m in mySentMessages) {
                      m.sentOrReceived = SentOrReceived.SENT;
                      m.createdAt = "20:00";
                    }
                    for (var m in myReceivedMessages) {
                      m.sentOrReceived = SentOrReceived.RECEIVED;
                      m.createdAt = "20:00";
                    }
                    setState(() {
                      chatMessages.addAll(mySentMessages);
                      chatMessages.addAll(myReceivedMessages);
                    });
                    try {
                      var maxScrollPosition = _msgScrollController.position.maxScrollExtent;
                      _msgScrollController.animateTo(maxScrollPosition + 100, curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
                    } catch (e) {}
                  }
                },
                child: BlocBuilder(
                  bloc: _consultancyBloc,
                  builder: (context, chatState) {
                    if (chatState is MessagesByEmailUninitialized) {
                      return BusyIndicator();
                    }
                    if (chatState is MessagesByEmailError) {
                      return Center(
                        child: CircleIconButton(
                          icon: Icons.refresh,
                          color: Colors.grey,
                          size: 50,
                          iconSize: 40,
                          tapRadius: 50,
                          callback: () async {
                            await _fetchInitData();
                          },
                        ),
                      );
                    }
                    if (chatState is MessagesByEmailLoaded) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: BlocListener(
                                        bloc: _sendMessageBloc,
                                        listener: (context, sendState) {
                                          if (sendState is SendTextMessageFinished) {
                                            // _consultancyBloc.add(UpdateDeliveredMessage(uuid: sendState.uuid, message: sendState.message));
                                          }
                                        },
                                        child: BlocBuilder(
                                          bloc: _sendMessageBloc,
                                          builder: (context, sendState) {
                                            return ListView.builder(
                                              controller: _msgScrollController,
                                              padding: const EdgeInsets.all(15),
                                              itemCount: chatMessages.length,
                                              itemBuilder: (ctx, i) {
                                                var message = chatMessages.elementAt(i);
                                                if (message.sentOrReceived == SentOrReceived.RECEIVED) {
                                                  if (message.type == MessageType.PHOTO) {
                                                    return ReceivedImageMessagesWidget(
                                                      message: message,
                                                      callback: () {
                                                        showChatImagesGallery(message);
                                                      },
                                                    );
                                                  } else if (message.type == MessageType.TEXT) {
                                                    return ReceivedMessagesWidget(message: message);
                                                  }
                                                } else {
                                                  if (message.type == MessageType.PHOTO) {
                                                    return SentImageMessageWidget(
                                                      sendState: sendState,
                                                      message: message,
                                                      callback: () {
                                                        showChatImagesGallery(message);
                                                      },
                                                    );
                                                  } else {
                                                    return SentMessageWidget(sendState: sendState, message: message);
                                                  }
                                                }
                                                return SizedBox();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _showBottom
                                    ? Positioned.fill(child: GestureDetector(onTap: () {
                                        setState(() {
                                          _showBottom = false;
                                        });
                                      }))
                                    : SizedBox(),
                                _showBottom ? _makeContentSelectorContainer() : Container(),
                              ],
                            ),
                          ),
                          _makeChatBottomArea(context),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _makeChatBottomArea(BuildContext context) {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [BoxShadow(offset: Offset(0, 0), blurRadius: 0, color: Colors.grey)],
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              controller: _txtMessageController,
              onChanged: (text) {
                setState(() {
                  _showBottom = false;
                  _showSendMessage = text.length > 0;
                });
              },
              onTap: () {
                setState(() {
                  _showBottom = false;
                });
              },
              decoration: InputDecoration(hintText: "Type something...", border: InputBorder.none),
            ),
          )),
          !_showSendMessage
              ? CircleIconButton(
            icon: Icons.attach_file,
            color: Colors.white,
            iconColor: Colors.grey,
            callback: () async {
              if (Platform.isAndroid) {
                var permissions = List<PermissionName>();
                permissions.add(PermissionName.Storage);
                var results = await Permission.getPermissionsStatus(permissions);
                var storageStatus = results[0].permissionStatus;
                if (storageStatus == PermissionStatus.allow) {
                  setState(() {
                    _showBottom = !_showBottom;
                  });
                } else {
                  var result = await Permission.requestPermissions(permissions);
                  if (result[0].permissionStatus == PermissionStatus.allow) {
                    setState(() {
                      _showBottom = !_showBottom;
                    });
                  }
                }
              } else {
                setState(() {
                  _showBottom = !_showBottom;
                });
              }
            },
          )
              : SizedBox(),
          CircleIconButton(
            icon: Icons.send,
            color: Colors.white,
            callback: () async {
              setState(() {
                _showBottom = false;
              });
              if (_showSendMessage) {
                if (_txtMessageController.text.isNotEmpty) {
                  _sendNewMessage(MessageType.TEXT, _txtMessageController.text);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  _makeContentSelectorContainer() {
    return Positioned(
      bottom: 8,
      left: 8,
      right: 8,
      child: Container(
          height: 160,
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [BoxShadow(offset: Offset(0, 5), blurRadius: 15.0, color: Colors.grey)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleIconButton(
                    icon: Icons.image,
                    color: Colors.purple,
                    size: 70,
                    iconSize: 40,
                    tapRadius: 50,
                    callback: () {
                      setState(() {
                        _showBottom = false;
                      });
                      _pickOrTakePhoto(ImageSource.gallery);
                    },
                  ),
                  SizedBox(height: 8),
                  Text("Gallery", style: TextStyle(color: Colors.grey))
                ],
              ),
              Column(
                children: <Widget>[
                  CircleIconButton(
                    icon: Icons.camera,
                    color: Colors.orangeAccent,
                    size: 70,
                    iconSize: 40,
                    tapRadius: 50,
                    callback: () {
                      setState(() {
                        _showBottom = false;
                      });
                      _pickOrTakePhoto(ImageSource.camera);
                    },
                  ),
                  SizedBox(height: 8),
                  Text("Camera", style: TextStyle(color: Colors.grey))
                ],
              ),
            ],
          )),
    );
  }

  void _pickOrTakePhoto(ImageSource fromSource) async {
    var image = await ImagePicker.pickImage(source: fromSource);
    if (image != null) {
      _sendNewMessage(MessageType.PHOTO, image.path, file: image);
    }
  }

  void showChatImagesGallery(MessageModel currentMessage) {
    var photoMessages = chatMessages.where((x) => x.type == MessageType.PHOTO).toList();
    if (photoMessages.length > 0) {
      var index = photoMessages.indexOf(currentMessage);
      List<GalleryPhotoItem> galleryItems = new List(photoMessages.length);
      for (var m in photoMessages) {
        if (m.message.isNotEmpty && m.message.contains(',')) {
          var urlSegments = m.message.split(",");
          var mainUrl = urlSegments[0];
          galleryItems[photoMessages.indexOf(m)] = new GalleryPhotoItem(id: _uuid.v4(), resource: "/$mainUrl");
        }
      }
      openPhotoViewer(context, galleryItems, index);
    }
  }

  void openPhotoViewer(BuildContext context, List<GalleryPhotoItem> galleryItems, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          usePageViewWrapper: false,
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          initialIndex: index,
        ),
      ),
    );
  }

  _sendNewMessage(MessageType type, String content, {File file}) {
    var messageUId = _uuid.v4();
    var messageToSend = MessageModel(
      id: messageUId,
      type: type,
      file: file,
      uuid: messageUId,
      message: content,
      msgFrom: widget.currentUser.email,
      msgTo: widget.contact.email,
      sentOrReceived: SentOrReceived.SENT,
      createdAt: "Now",
      image: "",
      messageStatus: true,
      toName: "",
    );
    _consultancyBloc.add(NewMessageAdded(message: messageToSend));
    _sendMessageBloc.add(SendTextMessage(message: messageToSend, accessToken: widget.accessToken, uuid: messageUId));
    _txtMessageController.text = "";
    setState(() {
      _showSendMessage = false;
    });
  }
}
