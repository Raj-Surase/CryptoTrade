import 'package:cryptotrade/Screens/Modules/dialogboxbutton.dart';
import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.widget,
  });

  final CoinController controller;
  final CoinDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceFG,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Trade ${controller.coinList[widget.selectedCoin].name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFFFAFBFC),
              ),
            ),
            SizedBox(height: 20),
            DialogTextButton(
                iconName: Icons.file_upload_outlined,
                iconText: "Buy",
                destinationPage: "BuyCrypto",
                col: AppColors.greenMain),
            DialogTextButton(
                iconName: Icons.file_download_outlined,
                iconText: "Sell",
                destinationPage: "SellCrypto",
                col: AppColors.redMain),
            DialogTextButton(
                iconName: Icons.currency_exchange,
                iconText: "Convert",
                destinationPage: "ConvertCrypto",
                col: AppColors.primaryMain),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Close",
                              style: GoogleFonts.getFont('Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textHi),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
