import 'package:flutter/material.dart';
import 'package:kai_mobile/core/repository/ticket_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';

class HistoryTicket extends ChangeNotifier {
  HistoryTicket() {
    init();
  }

  List tickets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void init() async {
    await getTicketsHistory();
  }

  Future getTicketsHistory() async {
    try {
      isLoading = true;
      var res = await TicketRepository.ticketHistories();
      isLoading = false;
      tickets = res;
    } catch (e) {
      errorSnackBar("Anda belum login, silahkan login terlebih dahulu");
    }
  }
}
