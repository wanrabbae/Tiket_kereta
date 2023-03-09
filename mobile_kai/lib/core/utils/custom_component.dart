import 'package:flutter/material.dart';
import 'package:kai_mobile/core/utils/constant.dart';

void infoSnackBar(String message,
    {bool showTextButton = false,
    String titleButton = "restart",
    Function? onPressedText,
    Duration? duration}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
      content: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: kLarge),
          Expanded(child: Text(message)),
          Visibility(
            visible: showTextButton,
            child: TextButton(
                onPressed: onPressedText == null ? null : onPressedText(),
                child: Text("$titleButton",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    ),
  );
}

void errorSnackBar(dynamic error) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: kLarge),
          Expanded(
              child: Text(error.toString(),
                  style: TextStyle(color: Colors.white))),
        ],
      ),
    ),
  );
}

CustomSnackBar(
  String? text, [
  isSuccess = true,
]) =>
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showSnackBar(SnackBar(
      content: Text("Anda harus login terlebih dahulu"),
      backgroundColor: Colors.red,
    ));
