import 'package:cryptotrade/models/api_model.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoinController extends GetxController {
  RxList<Coin> coinList = <Coin>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataLocally();
    fetchCoin();
  }

  Future<void> fetchDataLocally() async {
    final cachedData = await APICallModel.getDataLocally('coinList');
    if (cachedData != null) {
      coinList.value = List<Coin>.from(cachedData.map((x) => Coin.fromJson(x)));
    }
  }

  fetchCoin() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
      List<Coin> coins = coinFromJson(response.body);
      coinList.value = coins;
      APICallModel.storeDataLocally('coinList', coins);
    } finally {
      isLoading(false);
    }
  }
}
