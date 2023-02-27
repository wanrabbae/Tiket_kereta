import 'package:flutter/material.dart';
import 'package:kai_mobile/core/repository/ticket_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';

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
}
