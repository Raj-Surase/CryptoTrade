import 'package:cryptotrade/Screens/Modules/aboutcoin.dart';
import 'package:cryptotrade/Screens/Modules/chartbuttons.dart';
import 'package:cryptotrade/Screens/Modules/coinchart.dart';
import 'package:cryptotrade/Screens/Modules/coincontainer.dart';
import 'package:cryptotrade/Screens/Modules/coindisplay.dart';
import 'package:cryptotrade/Screens/Modules/coininfo.dart';
import 'package:cryptotrade/Screens/Modules/dialogbox.dart';
import 'package:cryptotrade/Screens/Modules/dialogboxbutton.dart';
import 'package:cryptotrade/Screens/home.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cryptotrade/constants/app_colors.dart';

import 'package:cryptotrade/models/charts_model.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/services.dart';
import 'assetpricechat.dart';
import 'package:intl/intl.dart';

class CoinDetailsScreen extends StatefulWidget {
  Coin coin;
  int selectedCoin;

  CoinDetailsScreen({
    required this.coin,
    required this.selectedCoin,
    Key? key,
  }) : super(key: key);

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  late Future<List<CoinDetailChartModel>> chartDetails;
  late TrackballBehavior trackballBehavior;
  final CoinController controller = Get.put(CoinController());
  final ChartsProvider chartsProvider =
      Get.put(ChartsProvider()); // Initialize ChartsProvider

  @override
  void initState() {
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
    // fetchChartData(); // Fetch data when the screen is initialized
    chartDetails = chartsProvider.getChartDetails(widget.coin.id);
  }

  // Future<void> fetchChartData() async {
  //   await chartsProvider.getChartDetails(widget.coin.id); // Fetch chart data
  //   setState(() {}); // Trigger a rebuild after data is fetched
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsProvider>(
        init: chartsProvider, // Initialize the controller
        builder: (chartsController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.surfaceBG,
              leading: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  // color: AppColors.surfaceFG,
                ),
                // height: ,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primaryOnSurface, size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                // widget.coin.name,
                widget.coin.name,
                style: GoogleFonts.getFont('Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textHi),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(widget.coin.currentPrice)}",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: widget.coin.currentPrice >= 0
                          ? AppColors.greenMain
                          : AppColors.redMain,
                    ),
                  ),
                ),
              ],
            ),
            // ),

            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    // Column(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    //       child: CoinDisplay(
                    //           controller: controller, widget: widget),
                    //     ),
                    //   ],
                    // ),
                    FutureBuilder<List<CoinDetailChartModel>>(
                        future:
                            ChartsProvider().getChartDetails(widget.coin.id),
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   return CircularProgressIndicator();
                          // } else if (snapshot.hasError) {
                          //   return Text('Error: ${snapshot.error}');
                          // } else if (!snapshot.hasData ||
                          //     snapshot.data!.isEmpty) {
                          //   return Text('No data available');
                          // } else {
                          return CoinChart(
                            controller: controller,
                            widget: widget.coin,
                            chartsProvider: chartsProvider,
                            selectedCoin: widget.selectedCoin,
                          );
                        }
                        // },
                        ),
                    // ChatButtons(
                    //   controller: controller,
                    //   widget: widget,
                    //   chartsController: chartsController,
                    // ),
                    CoinInfo(
                      controller: controller,
                      widget: widget.coin,
                      selectedCoin: widget.selectedCoin,
                    ),
                    AboutCoin(
                      controller: controller,
                      widget: widget.coin,
                      selectedCoin: widget.selectedCoin,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                        color: AppColors.greenMain,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _showBuyDialog(context);
                        },
                        child: Text(
                          'Trade',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFAFBFC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showBuyDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(controller: controller, widget: widget);
      },
    );
  }
}
