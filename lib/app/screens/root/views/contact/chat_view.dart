import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/screens/root/views/contact/controllers/chats_controller.dart';
import 'package:start/app/screens/root/views/contact/info_view.dart';
import 'package:start/app/screens/root/views/contact_view.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/models/friend.dart';
import 'package:start/app/models/chat.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  final Friend friend;
  const ChatView({Key? key, required this.friend}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final contactc = Get.put(ContactController());
  final chatc = Get.put(ChatsController());
  final authc = Get.put(AuthController());

  String timeNow = DateFormat('hh:mm a').format(DateTime.now());

  FocusNode focus = FocusNode();
  Color _color = Colors.black;
  String editUserName = '';
  String editID = '';
  bool option = false;
  bool edit = false;
  int no = 0;

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
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    // print(sheight);
    // print(swidth);

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
                constraints: BoxConstraints(
                  minHeight: sheight, // minimum width
                ),
                padding: EdgeInsets.only(
                    top: sheight * 0.08, bottom: sheight * 0.05),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatc.users.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      bottom: sheight * 0.05, top: sheight * 0.05),
                  itemBuilder: (BuildContext context, int index) {
                    bool lastTalk = index < chatc.users.length - 1
                        ? chatc.users[index].username ==
                            chatc.users[index + 1].username
                        : false;
                    return Visibility(
                      visible: widget.friend.getId().toString() ==
                          chatc.users[index].getFriendId(),
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: lastTalk ? 5 : 15, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: chatc.users[index].username ==
                                  authc.username.value
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: option == true &&
                                  chatc.users[index].username ==
                                      authc.username.value &&
                                  index == no,
                              child: Options(
                                width: swidth,
                                height: sheight,
                                index: index,
                                no: [1, 0],
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  if (option && no != index) {
                                    option = true;
                                  } else {
                                    option = !option;
                                  }

                                  no = index;
                                });
                              },
                              onTap: () {
                                if (option && index == no) {
                                  setState(() {
                                    option = false;
                                  });
                                }
                              },
                              child: Container(
                                child: CustomPaint(
                                  painter: lastTalk
                                      ? BaseChat()
                                      : chatc.users[index].username ==
                                              authc.username.value
                                          ? TailChat()
                                          : FriendTailChat(),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: swidth * 0.1,
                                      maxWidth: swidth * 0.6,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    child: Text(
                                      chatc.users[index].getMessage(),
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: option == true &&
                                  chatc.users[index].username !=
                                      authc.username.value &&
                                  index == no,
                              child: Options(
                                width: swidth,
                                height: sheight,
                                index: index,
                                no: [0, 1],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => InfoView(friend: widget.friend));
                },
                child: Container(
                    height: sheight / 8.5,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        right: swidth / 45,
                        left: swidth / 45,
                        top: sheight / 30),
                    decoration: BoxDecoration(color: HexColor('2c698d')),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: swidth / 18,
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: textBar(
                              colors: [HexColor('ffffff')],
                              fontweight: FontWeight.w900,
                              text: 'GalleryHub',
                              font: 'AndersonGrotesk',
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
                        Icons.play_arrow,
                        size: 26,
                      ),
                      onPressed: () {
                        setState(() {
                          const uuid = Uuid();
                          // print(authc.id.value);
                          if (edit) {
                            chatc.updateChat(Chat(
                                id: editID,
                                username: editUserName,
                                message: contactc.messageC.text,
                                friend_id: widget.friend.getId().toString(),
                                time: timeNow));
                            edit = false;
                          } else {
                            if (contactc.messageC.text == 'Alhamdulillah ') {
                              chatc.addChat(Chat(
                                  id: uuid.v4(),
                                  username: widget.friend.getUserName(),
                                  message: contactc.messageC.text,
                                  friend_id: widget.friend.getId().toString(),
                                  time: timeNow));
                            } else {
                              chatc.addChat(Chat(
                                  id: uuid.v4(),
                                  username: authc.username.value,
                                  message: contactc.messageC.text,
                                  friend_id: widget.friend.getId().toString(),
                                  time: timeNow));
                            }
                          }
                          contactc.messageC.text = '';
                        });
                      },
                    ),
                    suffixIconColor: _color,
                    contentPadding: const EdgeInsets.only(left: 20, top: 17),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Container Options(
      {required double width,
      required double height,
      required int index,
      List no = const []}) {
    List options = [
      GestureDetector(
        onTap: () {
          setState(() {
            chatc.removeChat(chatc.users[index]);
            option = !option;
          });
        },
        child: Wrap(
          spacing: -1.5,
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: [
            Icon(
              Icons.close_rounded,
              size: height * 0.03125,
              color: Colors.white,
            ),
            Text(
              'delete',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: height * 0.012,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            contactc.messageC.text = chatc.users[index].getMessage();
            editUserName = chatc.users[index].getUsername();
            editID = chatc.users[index].getId();
            edit = true;
          });
        },
        child: Wrap(
          direction: Axis.vertical,
          spacing: 1,
          children: [
            Icon(
              Icons.edit,
              size: height * 0.0275,
              color: Colors.white,
            ),
            Text(
              'update',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: height * 0.012,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    ];

    return Container(
      width: width * 0.22,
      height: height * 0.055,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          options[no[0]],
          options[no[1]],
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.015),
      decoration: BoxDecoration(
          color: HexColor('1B1A38').withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}

class FriendTailChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()..color = HexColor('AAF7A7');
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
    final Paint paint = new Paint()..color = HexColor('AAF7A7');
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
    final Paint paint = new Paint()..color = HexColor('AAF7A7');
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
