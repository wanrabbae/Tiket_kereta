import 'dart:convert';
import 'dart:developer';
import 'dart:js';

import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<SharedPreferences> pref = SharedPreferences.getInstance();

  static Future checkSession() async {
    var session = await pref;
    var _token = session.getString("token");
    if (_token != null) {
      token = _token;
      print("Token = $token");
      goRemove(BottomBar(0), context);
    }
  }

  static Future setToken(String token) async {
    var session = await pref;
    session.setString(
      "token",
      token,
    );
    var _token = session.getString("token");
    token = _token!;
  }

  static Future clearSession() async {
    var session = await pref;
    session.clear();
    goRemove(SplashScreen(), context);
  }
}
