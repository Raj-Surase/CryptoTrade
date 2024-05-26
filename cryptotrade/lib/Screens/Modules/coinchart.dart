import 'package:cryptotrade/Screens/assetpricechat.dart';
import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/api_model.dart';
import 'package:cryptotrade/models/charts_model.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinChart extends StatefulWidget {
  const CoinChart({
    super.key,
    required this.controller,
    required this.widget,
    required this.chartsProvider,
    required this.selectedCoin,
  });

  final CoinController controller;
  // final CoinDetailsScreen widget;
  final Coin widget;
  final int selectedCoin;
  final ChartsProvider chartsProvider;

  @override
  State<CoinChart> createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> {
  @override
  Widget build(BuildContext context) {
    // Define a key for the shared preferences
    final String _cacheKey = '${widget.widget}-chartDetails';

    // Function to load chart data from cache
    Future<List<CoinDetailChartModel>> _loadChartDataFromCache() async {
      final cachedData = await APICallModel.getDataLocally(_cacheKey);
      if (cachedData != null) {
        List<CoinDetailChartModel> cachedChartData =
            List<CoinDetailChartModel>.from(
          cachedData.map((x) => CoinDetailChartModel.fromJson(x)),
        );
        return cachedChartData;
      } else {
        return [];
      }
    }

    // Function to save chart data to cache
    Future<void> _saveChartDataToCache(
        List<CoinDetailChartModel> chartData) async {
      APICallModel.storeDataLocally(_cacheKey, chartData);
    }

    // Load chart data from cache during initialization
    _loadChartDataFromCache().then((cachedChartData) {
      if (cachedChartData.isNotEmpty) {
        // Use cached data if available
        widget.chartsProvider.coinDetailsChartList.assignAll(cachedChartData);
      }
    });

    return SizedBox(
      height: 300,
      child: widget.chartsProvider.isLoadChart
          ? Center(
              child: Container(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            ) // Show loading indicator
          : Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: AssetPriceChart(
                  index: widget.controller.coinList[widget.selectedCoin]
                      .priceChangePercentage24H,
                  data: widget.chartsProvider.coinDetailsChartList
                      .map(
                        (chartModel) => FlSpot(
                          chartModel.time?.toDouble() ?? 0.0,
                          chartModel.close?.toDouble() ?? 0.0,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
