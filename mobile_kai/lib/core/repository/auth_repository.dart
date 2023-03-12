import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kai_mobile/core/model/NewsModel.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';

class AuthRepository {
  static Future register(Map<String, dynamic> requestBody) async {
    try {
      var res =
          await dio.post("$endpointIP/register-customer", data: requestBody);
      log(res.realUri.toString());
      return res.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 500) {
        return e.response;
      } else {
        return e.response;
      }
    }
  }

  static Future login(Map<String, dynamic> requestBody) async {
    try {
      var res = await dio.post("$endpointIP/login-customer", data: requestBody);
      log(res.realUri.toString());
      return res.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 500) {
        return {"status": 400, "message": "Incorrect email or password"};
      } else {
        return {"status": 400, "message": "Incorrect email or password"};
      }
    }
  }

  static Future getProfileData() async {
    try {
      var token = await SessionManager.getToken();
      var res = await dio.get(
        "$endpointIP/customer",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      log(res.realUri.toString());
      return res.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 500) {
        return {"status": 400, "message": "Ups something went wrong!"};
      } else {
        print(e.message.toString());
      }
    }
  }
}
