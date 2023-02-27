import 'dart:developer';

import 'package:kai_mobile/core/utils/constant.dart';

class TicketRepository {
  static Future findTicket(data) async {
    var res = await dio.get(
        "$endpointIP/findTicket?depart=${data['from']}&arrival=${data['to']}");
    // print(res);
    log(res.realUri.toString());
    if (res.statusCode == 200) {
      return res.data;
    }
  }
}
