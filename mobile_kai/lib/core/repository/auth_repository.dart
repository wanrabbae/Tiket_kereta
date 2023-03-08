import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kai_mobile/core/model/NewsModel.dart';
import 'package:kai_mobile/core/utils/constant.dart';

class AuthRepository {
  static Future register(Map<String, dynamic> requestBody) async {
    var res = await dio.post(
      "$endpointIP/register-customer",
      data: jsonEncode(requestBody),
    );

    log(res.realUri.toString());

    if (res.statusCode == 201) {
      return res.data;
    } else if (res.statusCode == 400) {
      return res.data;
    }
  }

  static Future login(Map<String, dynamic> requestBody) async {
    try {
      var res = await dio.post(
        "$endpointIP/login-customer",
        data: jsonEncode(requestBody),
      );
      print(res.data);
      log(res.realUri.toString());
      // print(res.statusCode);
      return res.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return {"status": 400, "message": "Incorrect email or password"};
      } else {
        print(e.message.toString());
      }
    }
  }
}
