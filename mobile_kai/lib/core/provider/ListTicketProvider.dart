import 'package:flutter/material.dart';
import 'package:kai_mobile/core/repository/ticket_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';

class TicketProvider extends ChangeNotifier {
  // HomeProvider() {
  //   init();
  // }

  List tickets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future getTickets(data) async {
    try {
      _isLoading = true;
      var res = await TicketRepository.findTicket(data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      CustomSnackBar("Error fetching news!", false);
    }
  }

  Future booked(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await TicketRepository.bookTicket(requestBody);
    isLoading = false;
    if (res.statusCode == 201) {
      successSnackBar("Berhasil memesan tiket");
      return res.data;
    } else {
      errorSnackBar("Gagal memesan tiket!");
    }
  }
}
