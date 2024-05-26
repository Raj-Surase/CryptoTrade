import 'dart:convert';

import 'package:cryptotrade/models/api_model.dart';
import 'package:cryptotrade/models/charts_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChartsProvider extends GetxController {
  RxList<CoinDetailChartModel> coinDetailsChartList =
      <CoinDetailChartModel>[].obs;
  String enDescCoin = "";

  RxList<ChartBottomModel> list = <ChartBottomModel>[
    ChartBottomModel(text: "D", isClick: false),
    ChartBottomModel(text: "W", isClick: false),
    ChartBottomModel(text: "M", isClick: true),
    ChartBottomModel(text: "Y", isClick: false),
  ].obs;
  bool isLoadChart = false, isLoadCoin = false;
  int day = 30;

  Future<List<CoinDetailChartModel>> getChartDetails(String id) async {
    try {
      isLoadChart = true;
      final response = await APICallModel.getAPICallMethod(
          "https://api.coingecko.com/api/v3/coins/$id/ohlc?vs_currency=inr&days=$day");

      if (response.statusCode == 200) {
        Iterable i = json.decode(response.body);
        List<CoinDetailChartModel> l =
            i.map((e) => CoinDetailChartModel.fromJson(e)).toList();
        coinDetailsChartList.assignAll(l); // Use assignAll to update RxList
      }
    } catch (e) {
      isLoadChart = false;
      print(e.toString());
    }

    isLoadChart = false;
    update();
    return coinDetailsChartList;
  }

  void changeBool(int index) {
    list.forEach((e) => e.isClick = false);
    list[index].isClick = true;
    update();
  }

  void setDays(String text) {
    switch (text) {
      case "D":
        day = 1;
        break;
      case "W":
        day = 7;
        break;
      case "M":
        day = 30;
        break;
      case "Y":
        day = 365;
        break;
    }
    update();
  }

  Future<void> getCoinDetails(String id) async {
    try {
      isLoadCoin = true;
      final response = await APICallModel.getAPICallMethod(
          "https://api.coingecko.com/api/v3/coins/$id");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        enDescCoin = jsonResponse['description']['en'];
      }
    } catch (e) {
      isLoadCoin = false;
      print(e.toString());
    }

    isLoadCoin = false;
    update();
  }

  void updateChartList(List<CoinDetailChartModel> newList) {
    coinDetailsChartList.assignAll(newList);
    // Or you can use coinDetailsChartList = newList; depending on your needs
    update();
  }
}
