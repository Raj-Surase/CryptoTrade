import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

SliverChildBuilderDelegate CoinContainer(List<Coin> filteredData) {
  return SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinDetailsScreen(
                coin: filteredData[index],
                selectedCoin: index,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.surfaceFG,
                ),
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(filteredData[index].image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 0, 12),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              filteredData[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 130,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${filteredData[index].symbol.toUpperCase()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.textLo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(filteredData[index].currentPrice)}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "${filteredData[index].priceChangePercentage24H.toStringAsFixed(2)}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: filteredData[index]
                                                  .marketCapChangePercentage24H >=
                                              0
                                          ? AppColors.greenMain
                                          : AppColors.redMain,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    childCount: filteredData.length,
  );
}
