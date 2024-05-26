import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CoinDisplay extends StatefulWidget {
  const CoinDisplay({
    super.key,
    required this.controller,
    required this.widget,
  });

  final CoinController controller;
  final CoinDetailsScreen widget;

  @override
  State<CoinDisplay> createState() => _CoinDisplayState();
}

class _CoinDisplayState extends State<CoinDisplay> {
  @override
  void dispose() {
    // Dispose of CoinController and any other objects owned by it
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        widget.controller.coinList[widget.widget.selectedCoin].name,
        style: GoogleFonts.getFont('Roboto',
            fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textHi),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            "${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(widget.controller.coinList[widget.widget.selectedCoin].currentPrice)}",
            style: GoogleFonts.getFont(
              'Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: widget.controller.coinList[widget.widget.selectedCoin]
                          .currentPrice >=
                      0
                  ? AppColors.greenMain
                  : AppColors.redMain,
            ),
          ),
        ),
      ],
    );
  }
}
