import 'package:flutter/material.dart';
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

  Future login(Map<String, dynamic> requestBody) async {
    // isLoading = true;
    // // var res = await AuthRepository.login(requestBody);
    // isLoading = false;
    // print(res["status"]);
    // if (res["status"] == 200) {
    SessionManager.setToken("5|e36ttRpoIqcPTdi8iaJlRiL1hhwm2fI36O47XR3A");
    CustomSnackBar('Success login!');
    goRemove2(BottomBar(0));
    // } else if (res["status"] == 400) {
    //   CustomSnackBar(res["message"], false);
    // }
  }
}
