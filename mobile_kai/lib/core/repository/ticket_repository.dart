import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';

class TicketRepository {
  static Future findTicket(data) async {
    var res = await dio.get(
        "$endpointIP/findTicket?depart=${data['from']}&arrival=${data['to']}&date=${data['departTime']}");
    // print(res);
    log(res.realUri.toString());
    if (res.statusCode == 200) {
      return res.data;
    }
  }

  static Future bookTicket(data) async {
    var token = await SessionManager.getToken();
    var res = await dio.post("$endpointIP/booking",
        options: Options(
          followRedirects: false,
          // validateStatus: (status) {
          //   return status < 500;
          // },
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
        data: data);
    print(res);
    log(res.realUri.toString());
    return res;
  }

  static Future ticketHistories() async {
    try {
      var token = await SessionManager.getToken();
      var res = await dio.get(
        "$endpointIP/booking",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      log(res.realUri.toString());
      return res.data;
    } on DioError catch (e) {
      return {"status": 400, "message": "Error mengambil data riwayat tiket!"};
    }
  }
}
