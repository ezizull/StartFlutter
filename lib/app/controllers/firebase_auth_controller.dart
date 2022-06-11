import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      // print(userCredential);
      if (userCredential.user!.emailVerified) {
        Get.offAllNamed(Routes.ROOT);
      } else {
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  void forgotpass(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                            fontFamily: 'AndersonGrotesk'),
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
                    fontFamily: 'AndersonGrotesk'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void signup(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                            fontFamily: 'AndersonGrotesk'),
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
                    fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 0, top: 0),
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
                              fontFamily: 'AndersonGrotesk'),
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
                      fontFamily: 'AndersonGrotesk'),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                            fontFamily: 'AndersonGrotesk'),
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
                    fontFamily: 'AndersonGrotesk'),
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
        String username = userCredential.user!.displayName ?? '';
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

  @override
  void onInit() {
    super.onInit();
  }
}
