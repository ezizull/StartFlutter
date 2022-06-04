import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/models/friend.dart';

import 'package:start/app/modules/home/views/contact/chat_view.dart';
import 'package:start/app/modules/home/views/contact_view.dart';
import 'package:start/app/utilities/toCapitalize.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final AuthController authc = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: authc.firends.map((friend) {
          return ChatWidget(friend: friend, time: authc.timeNow);
        }).toList(),
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  final String time;
  final Friend friend;

  const ChatWidget({
    Key? key,
    required this.friend,
    required this.time,
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final contactc = Get.put(ContactController());

  final double hchat = 90;

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(friend: widget.friend)));
        setState(() {});
      },
      child: Container(
        height: hchat,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: swidth * 0.07,
                  backgroundColor: widget.friend.Online()
                      ? HexColor('2fcf70')
                      : HexColor('ff2c2c'),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${widget.friend.imgUrl()}',
                    ),
                    backgroundColor: Colors.transparent,
                    radius: swidth * 0.062,
                  ),
                ),
                Container(
                  width: swidth * 0.62,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          toCapitalize(widget.friend.getFullName()),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.friend.getAbout(),
                          maxLines: 1,
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 8),
              child: Text(
                this.widget.time,
                style: TextStyle(fontSize: 12),
              ),
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
      ),
    );
  }
}
