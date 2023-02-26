import 'package:flutter/material.dart';
import 'package:kai_mobile/core/model/NewsModel.dart';
import 'package:kai_mobile/core/repository/home_repository.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    init();
  }

  List newsData = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void init() async {
    await getNewsData();
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
      CustomSnackBar("Error fetching news!");
    }
  }
}
