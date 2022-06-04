import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:transparent_image/transparent_image.dart';

class AddChatView extends StatefulWidget {
  const AddChatView({Key? key}) : super(key: key);

  @override
  State<AddChatView> createState() => _AddChatViewState();
}

class _AddChatViewState extends State<AddChatView> {
  Iterable<Contact> _contacts = [];

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Container(
      child: _contacts != null
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search People',
                      fillColor: HexColor('ffffff'),
                      filled: true,
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 18, bottom: 18),
                    ),
                  ),
                ),
                Column(
                    children: _contacts.map(
                  (contact) {
                    if (contact.phones != null) {
                      // print(inspect(contact));
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: swidth * 0.055,
                            backgroundImage: MemoryImage(
                                contact.avatar ?? kTransparentImage),
                            child: contact.avatar == null
                                ? Text(contact.initials())
                                : null,
                            backgroundColor: contact.avatar == null
                                ? Theme.of(context).accentColor
                                : null,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    contact.displayName ??
                                        contact.phones![0].value.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(contact.emails![0].value.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList()),
              ],
            )
          : Container(
              height: sheight * 0.7,
              child: Center(child: const CircularProgressIndicator())),
    );
  }
}
