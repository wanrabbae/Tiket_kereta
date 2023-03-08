import 'package:flutter/material.dart';
import 'package:kai_mobile/core/repository/auth_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
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
    print(res);
    // if (res["status"] == 200) {
    //   SessionManager.setToken(res["token"]);
    //   goRemove2(BottomBar(0));
    //   CustomSnackBar(res["message"]);
    // } else if (res["status"] == 400) {
    //   CustomSnackBar(res["message"], false);
    // }
  }
}
