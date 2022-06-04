import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:start/app/models/dummy_data.dart';
import 'package:start/app/models/friend.dart';
import 'package:start/app/routes/app_pages.dart';

class AuthController extends GetxController {
  List<Map<String, dynamic>> dummy = DummyData.data;

  RxString id = ''.obs;
  RxString nim = ''.obs;
  RxString nama = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxBool valid = false.obs;

  List<Friend> firends = [];
  final random = Random();
  String timeNow = DateFormat('hh:mm a').format(DateTime.now());

  @override
  void onInit() {
    for (var id = 0; id < 3; id++) {
      // var fake = new Faker();
      firends.add(Friend(
        about: 'simply dummy text of the printing and typesetting industry',
        firstName: 'fname ${id}',
        lastName: random.nextBool() ? 'lname ${id}' : '',
        userName: 'username ${id}',
        online: random.nextBool(),
        id: id,
      ));
    }
    super.onInit();
  }

  void userData({
    required String id,
    required String username,
  }) {
    this.username.value = username;
    this.id.value = id;
    update();
  }

  void validation(String Email, String Password) {
    for (var data in dummy) {
      if ((data['nama'] == Email && data['Nim'] == Password) ||
          (data['username'] == Email && data['password'] == Password)) {
        valid.value = true;
        id.value = data['id'].toString();
        nim.value = data['Nim'];
        nama.value = data['nama'];
        username.value = data['username'];
        password.value = data['password'];
        Get.offAllNamed(Routes.ROOT);
      }
    }
    update();
  }

  void unvalid() {
    if (valid.isTrue) {
      valid.value = false;
      id.value = '';
      nim.value = '';
      nama.value = '';
      username.value = '';
      password.value = '';
    }
    update();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String Email, String Password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      print(userCredential);
      if (userCredential.user!.emailVerified) {
        userData(id: '0', username: Email);
        Get.offAllNamed(Routes.ROOT);
      } else {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'VERIFY!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'please check your email box',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'USER!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'user account doesnt exists',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'PASS!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'password is not correct',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      } else if (e.code == 'invalid-email') {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'EMAIL!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'your email is not correct',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  void forgotpass(String Email) async {
    if (Email != "" && GetUtils.isEmail(Email)) {
      try {
        await auth.sendPasswordResetEmail(email: Email);
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'RESET!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'reset password has send to your email',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'RESET!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'can\'t reset this account password',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 2, left: 2, bottom: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'EMAIL!',
                        style: TextStyle(
                            fontSize: 20,
                            color: HexColor('272643'),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.close(0);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('272643'),
                              minimumSize: Size(45, 30),
                              padding: EdgeInsets.all(0),
                            ),
                            child: Icon(Icons.close)))
                  ],
                ),
              ),
              Text(
                'your email is not correct',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: HexColor('272643'),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void signup(String Email, String Password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      await userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 2, left: 2, bottom: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'VERIFY!',
                        style: TextStyle(
                            fontSize: 20,
                            color: HexColor('272643'),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.close(0);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('272643'),
                              minimumSize: Size(45, 30),
                              padding: EdgeInsets.all(0),
                            ),
                            child: Icon(Icons.close)))
                  ],
                ),
              ),
              Text(
                'please check your email box',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: HexColor('272643'),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'PASS!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'please change the password is to weak',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 2, left: 2, bottom: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'EMAIL!',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('272643'),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.close(0);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('272643'),
                                minimumSize: Size(45, 30),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Icon(Icons.close)))
                    ],
                  ),
                ),
                Text(
                  'email account already exists',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor('272643'),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 2, left: 2, bottom: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'REGIST!',
                        style: TextStyle(
                            fontSize: 20,
                            color: HexColor('272643'),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.close(0);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('272643'),
                              minimumSize: Size(45, 30),
                              padding: EdgeInsets.all(0),
                            ),
                            child: Icon(Icons.close)))
                  ],
                ),
              ),
              Text(
                'can\'t register this account',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: HexColor('272643'),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void googleauth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(googleCredential);

      if (userCredential.user!.emailVerified) {
        String userName = userCredential.user!.displayName ?? '';
        userData(id: '0', username: userName);
        Get.offAllNamed(Routes.ROOT);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
