import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';

class ChatButtons extends StatelessWidget {
  const ChatButtons({
    super.key,
    required this.controller,
    required this.widget,
    required this.chartsController,
  });

  final CoinController controller;
  final CoinDetailsScreen widget;
  final ChartsProvider chartsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: SizedBox(
            height: 55,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chartsController.list.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        chartsController.changeBool(i);
                        chartsController.setDays(chartsController.list[i].text);
                        await chartsController.getChartDetails(
                          controller.coinList[widget.selectedCoin].id,
                        );
                      },
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: chartsController.list[i].isClick
                              ? AppColors.surfaceShape
                              : AppColors.primarySurface,
                        ),
                        child: Center(
                          child: Text(
                            chartsController.list[i].text,
                            style: TextStyle(color: AppColors.textHi),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
