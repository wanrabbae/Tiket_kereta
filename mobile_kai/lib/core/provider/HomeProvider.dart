import 'package:flutter/material.dart';
import 'package:kai_mobile/core/model/NewsModel.dart';
import 'package:kai_mobile/core/repository/home_repository.dart';
import 'package:kai_mobile/core/repository/ticket_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    init();
  }

  List newsData = [];
  List stationData = [];
  List tickets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void init() async {
    await getNewsData();
    await getStationData();
  }

  Future getNewsData() async {
    try {
      _isLoading = true;
      var res = await HomeRepository.getNews();
      newsData = res;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      CustomSnackBar("Error fetching news!", false);
    }
  }

  Future getStationData() async {
    try {
      _isLoading = true;
      var res = await HomeRepository.getStation();
      for (var i = 0; i < res.length; i++) {
        var data = res[i];
        stationData
            .add(data["station_name"] + " (" + data["station_code"] + ")");
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      CustomSnackBar("Error fetching news!", false);
    }
  }

  Future getTickets(data) async {
    try {
      // _isLoading = true;
      var res = await TicketRepository.findTicket(data);
      // _isLoading = false;
      return {"data": data, "response": res};
    } catch (e) {
      print(e);
      CustomSnackBar("Error fetching news!", false);
    }
  }
}
