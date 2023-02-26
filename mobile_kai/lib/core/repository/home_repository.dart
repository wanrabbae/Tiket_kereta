import 'dart:developer';

import 'package:kai_mobile/core/model/NewsModel.dart';
import 'package:kai_mobile/core/utils/constant.dart';

class HomeRepository {
  static Future getNews() async {
    var res = await dio.get("$endpointIP/news");

    log(res.realUri.toString());
    if (res.statusCode == 200) {
      return res.data;
    }
  }

  static Future getStation() async {
    var res = await dio.get("$endpointIP/stations");

    log(res.realUri.toString());
    if (res.statusCode == 200) {
      return res.data;
    }
  }
}
