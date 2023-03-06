import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile/core/utils/constant.dart';

Future goBack([args]) async =>
    Navigator.of(navigatorKey.currentContext!).pop(args);

Future goRemove(Widget widget, context) async => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: ((context) => widget)),
    ((route) => false));

Future goRemove2(Widget widget) async {
  return await Navigator.pushAndRemoveUntil(navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Future goPush(Widget widget, context) async =>
    Navigator.push(context, MaterialPageRoute(builder: ((context) => widget)));
