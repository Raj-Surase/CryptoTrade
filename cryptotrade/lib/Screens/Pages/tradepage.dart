import 'package:cryptotrade/Screens/Modules/cryptodropdown.dart';
import 'package:cryptotrade/Screens/Modules/pinscreen.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class BuyCrypto extends StatefulWidget {
  final String screen;

  const BuyCrypto({required this.screen, super.key});

  @override
  State<BuyCrypto> createState() => _BuyCryptoState();
}

class CryptoItem {
  final String name;
  final Image image;

  CryptoItem({required this.name, required this.image});
}

class _BuyCryptoState extends State<BuyCrypto> {
  String text = '';
  final CoinController controller = Get.put(CoinController());
  bool isKeyboardVisible = true;

  CryptoItem? selectedCrypto1;
  CryptoItem? selectedCrypto2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBG,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primaryOnSurface, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          widget.screen + " Crypto",
          style: GoogleFonts.getFont('Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textHi),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: widget.screen != "Convert"
                  ? CryptoDropDown(
                      uniqueId: "drop1",
                      onCryptoSelected: (crypto) {
                        setState(() {
                          selectedCrypto1 = crypto;
                        });
                      })
                  : Column(
                      children: [
                        CryptoDropDown(
                          uniqueId: "drop1",
                          onCryptoSelected: (crypto) {
                            setState(() {
                              selectedCrypto1 = crypto;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "To",
                          style: TextStyle(
                              color: AppColors.textLo,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CryptoDropDown(
                          uniqueId: "drop2",
                          onCryptoSelected: (crypto) {
                            setState(() {
                              selectedCrypto2 = crypto;
                            });
                          },
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            // widget.screen != "Convert"
                            //     ? text
                            //     : selectedCrypto1?.name ?? "123",
                            text,
                            style: GoogleFonts.robotoCondensed(
                              color: AppColors.textHi,
                              fontSize: 50,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "₹",
                        style: GoogleFonts.robotoCondensed(
                          color: AppColors.textDisabled,
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.screen == "Buy"
                        ? PinScreen(
                            destinationPage: "BuyCrypto",
                            amount: text,
                            selectedCrypto1: selectedCrypto1,
                          )
                        : widget.screen == "Sell"
                            ? PinScreen(
                                destinationPage: "SellCrypto",
                                amount: text,
                                selectedCrypto1: selectedCrypto1,
                              )
                            : PinScreen(
                                destinationPage: "ConvertCrypto",
                                amount: text,
                                selectedCrypto1: selectedCrypto2,
                              ),
                  ),
                );
                print(widget.screen);

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                //   decoration: BoxDecoration(
                //     color: AppColors.surfaceFG,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       topRight: Radius.circular(20),
                //     ),
                //   ),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           "Trade ${controller.coinList[1].name}",
                //           style: const TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 24,
                //             color: Color(0xFFFAFBFC),
                //           ),
                //         ),
                //         SizedBox(height: 20),
                //         InkWell(
                //           onTap: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: Column(
                //             children: [
                //               Container(
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(15),
                //                   color: Colors.transparent,
                //                 ),
                //                 height: 60,
                //                 child: Row(
                //                   children: [
                //                     Expanded(
                //                       child: Align(
                //                         alignment: Alignment.center,
                //                         child: Text(
                //                           "Close",
                //                           style: GoogleFonts.getFont('Roboto',
                //                               fontSize: 18,
                //                               fontWeight: FontWeight.w600,
                //                               color: AppColors.textHi),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
              style: ButtonStyle(
                iconColor: MaterialStatePropertyAll(AppColors.textLo),
              ),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.screen == "Buy"
                      ? AppColors.greenMain
                      : widget.screen == "Sell"
                          ? AppColors.redMain
                          : AppColors.yellowMain,
                ),
                child: Center(
                  child: Text(
                    widget.screen,
                    style: TextStyle(
                      color: AppColors.textHi,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: AppColors.surfaceFG,
              ),
              child: Column(
                children: [
                  VirtualKeyboard(
                    height: 300,
                    textColor: AppColors.textHi,
                    fontSize: 18,
                    type: VirtualKeyboardType.Numeric,
                    onKeyPress: _onKeyPress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fired when the virtual keyboard key is pressed.
  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (key.text ?? '');
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        // case VirtualKeyboardKeyAction.Return:
        //   text = text + '\n';
        //   break;
        // case VirtualKeyboardKeyAction.Space:
        //   // text = text + key.text;
        //   break;
        // case VirtualKeyboardKeyAction.Shift:
        //   shiftEnabled = !shiftEnabled;
        //   break;
        default:
      }
    }
    // Update the screen
    setState(() {});
  }
}
