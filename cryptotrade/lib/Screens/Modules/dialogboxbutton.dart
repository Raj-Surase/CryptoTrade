import 'package:cryptotrade/Screens/Modules/dialogbox.dart';
import 'package:cryptotrade/Screens/Pages/tradepage.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogTextButton extends StatelessWidget {
  const DialogTextButton({
    super.key,
    required this.iconName,
    required this.iconText,
    required this.destinationPage,
    required this.col,
  });

  final String iconText;
  final String destinationPage;
  final Color col;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          // _showBuyDialog(context, destinationPage);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => destinationPage == 'BuyCrypto'
                    ? BuyCrypto(screen: "Buy")
                    : destinationPage == 'SellCrypto'
                        ? BuyCrypto(screen: "Sell")
                        : destinationPage == 'ConvertCrypto'
                            ? BuyCrypto(screen: "Convert")
                            : Container()),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.surfaceStroke,
              ),
              height: 80,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Icon(
                      iconName,
                      color: AppColors.textHi,
                      size: 40,
                    ),
                  ),
                  Text(
                    iconText,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textHi,
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

  // void _showBuyDialog(BuildContext context, String destinationPage) {
  // late Widget content;

  // @override
  // void initState() {
  //   switch (destinationPage) {
  //     case 'Buy':
  //       content = BuyCrypto();
  //       break;
  //     case 'Sell':
  //       content = Placeholder();
  //       break;
  //     case 'Convert':
  //       content = Placeholder();
  //       break;
  //   }
  //   // );
  //   // super.initState();
  // }

  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return destinationPage == 'BuyCrypto'
  //           ? BuyCrypto()
  //           : destinationPage == 'send'
  //               ? Placeholder()
  //               : destinationPage == 'convert'
  //                   ? Placeholder()
  //                   : Container();
  //     },
  //   );
  // }
}
