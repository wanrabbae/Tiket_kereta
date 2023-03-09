import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile/core/repository/auth_repository.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    init();
  }
  final naviKey = GlobalKey<NavigatorState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Map userData = {};
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  init() async {
    var checkToken = await SessionManager.checkSession();
    if (checkToken) {
      await getProfile();
    }
  }

  Future register(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await AuthRepository.register(requestBody);
    isLoading = false;
    if (res["status"] == 201) {
      CustomSnackBar(res["message"]);
      goBack();
    } else if (res["status"] == 400) {
      CustomSnackBar(res["message"], false);
    }
  }

  Future login(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await AuthRepository.login(requestBody);
    isLoading = false;
    if (res["success"] == true) {
      SessionManager.setToken(res["token"], res["user"]["name"]);
      goRemove(BottomBar(0), naviKey.currentContext);
    } else if (res["status"] == 400 || res["status"] == 401) {
      errorSnackBar("Email atau Password salah!");
    }
  }

  Future? getProfile() async {
    isLoading = true;
    var res = await AuthRepository.getProfileData();
    isLoading = false;
    if (res["status"] == 400) {
      errorSnackBar("Ups something went wrong!");
    } else {
      userData = res;
    }
  }
}
