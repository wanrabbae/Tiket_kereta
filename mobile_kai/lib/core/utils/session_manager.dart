import 'dart:convert';
import 'dart:developer';

import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<SharedPreferences> pref = SharedPreferences.getInstance();

  static Future checkSession() async {
    var session = await pref;
    var _token = session.getString("token");
    if (_token != null) {
      token = _token;
      print("Token = $token");
      return true;
    }
    return false;
  }

  static Future getToken() async {
    var session = await pref;
    var _token = session.getString("token");
    if (_token != null) {
      token = _token;
      print("Token = $token");
      return _token;
    }
    return null;
  }

  static Future setToken(String token, String name) async {
    var session = await pref;
    session.setString(
      "token",
      token,
    );
    session.setString(
      "name",
      name,
    );
    var _token = session.getString("token");
    token = _token!;
    nama = name;
  }

  static Future clearSession() async {
    var session = await pref;
    session.clear();
    token = null;
    nama = null;
    goRemove2(BottomBar(0));
  }
}
