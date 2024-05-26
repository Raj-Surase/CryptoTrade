import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AboutCoin extends StatelessWidget {
  const AboutCoin({
    super.key,
    required this.controller,
    required this.widget,
    required this.selectedCoin,
  });

  final CoinController controller;
  final Coin widget;
  final int selectedCoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "About ${widget.name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFFFAFBFC),
              ),
            ),
          ),
          GetBuilder<ChartsProvider>(
            init: ChartsProvider(), // Initialize the controller
            builder: (chartsController) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: chartsController.getCoinDetails(
                    widget.id,
                  ),
                  builder: (context, asyncSnapshot) {
                    return Text(
                      chartsController.enDescCoin,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFBDBEC0),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      // )
      // ],
      // ),

      //   ],
      // ),
    );
  }
}
