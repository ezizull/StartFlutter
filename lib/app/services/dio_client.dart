import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/models/friend.dart';
import 'package:start/app/models/users.dart';

class DioClient {
  final Dio dio = Dio();
  final authc = Get.put(AuthController());

  static const baseURL = "http://10.0.2.2:8000";
  static const loginAPI = baseURL + "/api/login";
  static const getFriendAPI = baseURL + "/api/friend";
  static const addFriendAPI = "http://10.0.2.2:8000/api/friend/store";
  static const updateFriendAPI = "http://10.0.2.2:8000/api/friend";
  static const deleteFriendAPI = "http://10.0.2.2:8000/api/friend";

  Future<User> fetchLogin(
      {required String email,
      required String password,
      String device = 'mobile'}) async {
    try {
      final response = await dio.post(loginAPI, data: {
        'email': email,
        'password': password,
        'device_name': device,
      });

      authc.login(data: response.data, password: password);
      // debugPrint(response.data.toString());
      return User.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to login");
    }
  }

  Future<Friends> fetchFriend({required String token}) async {
    try {
      final response = await dio.get(
        getFriendAPI,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // debugPrint(response.data["data"].toString());
      return Friends.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to load friend");
    }
  }

  Future<Friend> addFriend(
      String firstname, String phone, String lastname) async {
    try {
      final response = await dio.post(
        addFriendAPI,
        queryParameters: {
          "firstname": firstname,
          "lastname": lastname,
          "phone": phone,
        },
      );
      debugPrint(response.toString());
      return Friend.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to create friend: ");
    }
  }

  Future<Friend> updateFriend(
      int friendId, String firstname, String phone, String lastname) async {
    try {
      final response = await dio.post(
        updateFriendAPI + "/$friendId",
        data: {
          "firstname": firstname,
          "lastname": lastname,
          "phone": phone,
        },
      );
      debugPrint(response.toString());
      return Friend.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to update friend: ");
    }
  }

  Future<void> deleteFriend(int friendId) async {
    try {
      await dio.get(deleteFriendAPI + "/$friendId");
      debugPrint('Delete Succes');
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to delete friend: $friendId");
    }
  }
}
