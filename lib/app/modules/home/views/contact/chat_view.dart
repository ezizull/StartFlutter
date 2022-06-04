import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/models/chat.dart';

import 'package:start/app/models/friend.dart';
import 'package:start/app/modules/home/views/contact/info_view.dart';
import 'package:start/app/modules/home/views/contact_view.dart';

class ChatView extends StatefulWidget {
  final Friend friend;
  const ChatView({Key? key, required this.friend}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final contactc = Get.put(ContactController());
  final authc = Get.put(AuthController());

  String timeNow = DateFormat('hh:mm a').format(DateTime.now());

  FocusNode focus = FocusNode();
  Color _color = Colors.black;
  List<Chat> usersChat = [];

  @override
  void initState() {
    focus.addListener(() {
      if (focus.hasFocus) {
        _color = HexColor('2c698d');
      } else {
        _color = Colors.black;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          color: HexColor('ffffff'),
          image: DecorationImage(
              image: AssetImage('assets/images/chatbg_7.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(top: 100, bottom: 60),
              child: ListView.builder(
                itemCount: usersChat.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (BuildContext context, int index) {
                  bool lastTalk = index < usersChat.length - 1
                      ? usersChat[index].username ==
                          usersChat[index + 1].username
                      : false;

                  print('${index} ${lastTalk}');
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: 250, // minimum width
                    ),
                    alignment: usersChat[index].username == authc.username.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        bottom: lastTalk ? 5 : 15, right: 10, left: 10),
                    child: CustomPaint(
                      painter: lastTalk
                          ? BaseChat()
                          : usersChat[index].username == authc.username.value
                              ? TailChat()
                              : FriendTailChat(),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 50,
                          maxWidth: 200,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        child: Text(
                          usersChat[index].getMessage(),
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => InfoView(), arguments: {
                  "id": widget.friend.getId(),
                  "imgUrl": widget.friend.imgUrl(),
                  "online": widget.friend.Online(),
                  "fullName": widget.friend.getFullName(),
                  "userName": widget.friend.getUserName(),
                });
              },
              child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                  decoration: BoxDecoration(color: HexColor('2c698d')),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: textBar(
                            colors: [HexColor('ffffff')],
                            fontweight: FontWeight.w800,
                            text: 'GalleryHub',
                            font: 'Roboto',
                            size: 20,
                          )),
                    ],
                  )),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextField(
                maxLines: null,
                controller: contactc.messageC,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Message',
                  fillColor: HexColor('ffffff'),
                  border: InputBorder.none,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 26,
                    ),
                    onPressed: () {
                      setState(() {
                        if (contactc.messageC.text == 'Alhamdulillah') {
                          usersChat.add(new Chat(
                              id: widget.friend.getId().toString(),
                              username: widget.friend.getUserName(),
                              message: contactc.messageC.text,
                              time: timeNow));
                        } else {
                          usersChat.add(new Chat(
                              id: authc.id.value,
                              username: authc.username.value,
                              message: contactc.messageC.text,
                              time: timeNow));
                        }
                      });
                      // contactc.messageC.clear();
                    },
                  ),
                  suffixIconColor: _color,
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 18, bottom: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendTailChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()..color = HexColor('aaffaa');
    double corner = 10;

    Path path = Path();
    path.moveTo(size.width / 2 - corner, 0);
    path.lineTo(0, size.height / 2 + corner);
    path.lineTo(0, size.height + corner);
    path.lineTo(0 + corner, size.height);
    path.lineTo(size.width / 2 + corner, size.height);
    path.lineTo(size.width, size.height / 2 + corner);
    path.lineTo(size.width / 2 + corner, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    final BorderRadius borderRadius = BorderRadius.circular(corner);
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TailChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()..color = HexColor('aaffaa');
    double corner = 10;

    Path path = Path();
    path.moveTo(size.width / 2 - corner, 0);
    path.lineTo(0, size.height / 2 + corner);
    path.lineTo(size.width - corner, size.height);
    path.lineTo(size.width, size.height + corner / 2);
    path.lineTo(size.width, size.height / 2 + corner);
    path.lineTo(size.width / 2 + corner, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    final BorderRadius borderRadius = BorderRadius.circular(corner);
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BaseChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()..color = HexColor('aaffaa');
    double corner = 10;

    Path path = Path();
    path.moveTo(size.width / 2 - corner, 0);
    path.lineTo(0, size.height / 2 + corner);
    path.lineTo(size.width / 2 + corner, size.height);
    path.lineTo(size.width, size.height / 2 + corner);
    path.lineTo(size.width / 2 + corner, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    final BorderRadius borderRadius = BorderRadius.circular(corner);
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ListView(
//   shrinkWrap: true,
//   children: [
//     Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: usersChat.map((userChat) {
//         var index = usersChat.indexOf(userChat);
        // bool oneChat = index > 0
        //     ? userChat.username == usersChat[index - 1].username
        //     : false;

//         if (userChat.username == authc.username.value) {
//           return Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   constraints: BoxConstraints(
//                     minWidth: 250, // minimum width
//                   ),
//                   alignment: Alignment.centerRight,
//                   margin: EdgeInsets.only(
//                       top: oneChat ? 0 : 15,
//                       bottom: 5,
//                       right: 10,
//                       left: 10),
//                   child: CustomPaint(
//                     painter: oneChat ? BaseChat() : TailChat(),
//                     child: Container(
//                       constraints: BoxConstraints(
//                         minWidth: 50,
//                         maxWidth: 200,
//                       ),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 12),
//                       child: Text(
//                         userChat.getMessage(),
//                         style: TextStyle(
//                           fontSize: 15.5,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 constraints: BoxConstraints(
//                   minWidth: 250, // minimum width
//                 ),
//                 alignment: Alignment.centerLeft,
//                 margin: EdgeInsets.only(
//                     top: oneChat ? 0 : 15,
//                     bottom: 5,
//                     right: 10,
//                     left: 10),
//                 child: CustomPaint(
//                   painter:
//                       oneChat ? BaseChat() : FriendTailChat(),
//                   child: Container(
//                     constraints: BoxConstraints(
//                       minWidth: 50,
//                       maxWidth: 200,
//                     ),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 12),
//                     child: Text(
//                       userChat.getMessage(),
//                       style: TextStyle(
//                         fontSize: 15.5,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     ),
//   ],
// ),