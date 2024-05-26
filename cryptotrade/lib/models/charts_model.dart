// import 'package:get/get.dart';
// import 'crypto_data_model.dart';
// import 'package:http/http.dart' as http;

// class CoinDetailChartModel extends GetxController {
//   RxList<CryptoDataModel> coinsList = <CryptoDataModel>[].obs;

//   fetchCoins() async {
//     var response = await http.get(Uri.parse(
//         'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));

//     List<CryptoDataModel> coins = cryptoDataModelFromJson(response.body);

//     coinsList.value = coins;
//   }
// }

class CoinDetailChartModel {
  int? time;
  double? open;
  double? high;
  double? low;
  double? close;

  CoinDetailChartModel(
      {required this.time, this.open, this.high, this.low, this.close});

  factory CoinDetailChartModel.fromJson(List list) {
    return CoinDetailChartModel(
        time: list[0],
        open: list[1],
        high: list[2],
        low: list[3],
        close: list[4]);
  }
}

class ChartBottomModel {
  String text;
  bool isClick;

  ChartBottomModel({required this.text, required this.isClick});
}
