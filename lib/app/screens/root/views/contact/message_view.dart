import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/models/friend.dart';

import 'package:start/app/utilities/toCapitalize.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/screens/root/views/contact_view.dart';
import 'package:start/app/screens/root/views/contact/chat_view.dart';

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
        children: authc.friends.map((friend) {
          return ChatWidget(friend: friend, time: authc.timeNow);
        }).toList(),
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  final Friend friend;
  final String time;

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
  bool option = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    int id = widget.friend.getId();

    return Obx(
      () => GestureDetector(
        onTap: () {
          if (!option) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatView(friend: widget.friend)));
          }

          if (contactc.select.contains(id)) {
            setState(() {
              option = false;
              contactc.removeSelect(id);
            });
          }
        },
        onLongPress: () {
          setState(() {
            option = !option;

            if (option) {
              contactc.addSelect(id);
            }

            if (!option) {
              contactc.removeSelect(id);
            }
          });
        },
        child: Stack(
          children: [
            Container(
              height: sheight / 13,
              margin: EdgeInsets.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 2.5, bottom: 1.6, top: 1.6),
                        width: swidth / 6.5,
                        height: sheight / 13,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${widget.friend.imgUrl()}',
                                ),
                                fit: BoxFit.cover,
                                opacity: 1)),
                      ),
                      Container(
                        width: swidth * 0.64,
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 2.5,
                          children: [
                            Container(
                              child: Text(
                                toCapitalize(widget.friend.getFullName()),
                                style: TextStyle(
                                    color: HexColor('42425B'),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.friend.getPhone(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: HexColor('42425B'),
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w100),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 8, right: 10, bottom: 10),
                    child: Text(
                      this.widget.time,
                      style: TextStyle(fontSize: 12),
                    ),
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: contactc.select.contains(id)
                    ? HexColor('F3F7F9')
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    width: 0.8,
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
