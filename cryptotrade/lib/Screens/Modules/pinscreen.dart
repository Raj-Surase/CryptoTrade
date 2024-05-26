import 'package:cryptotrade/Screens/Pages/balancepage.dart';
import 'package:cryptotrade/Screens/Pages/tradepage.dart';
import 'package:cryptotrade/Screens/Pages/transactionsuccess.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class PinScreen extends StatefulWidget {
  const PinScreen(
      {required this.destinationPage,
      this.amount,
      this.selectedCrypto1,
      super.key});

  final String destinationPage;
  final String? amount;
  final CryptoItem? selectedCrypto1;

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String text = '';
  bool isKeyboardVisible = true;
  Color containerColor = AppColors.textHi;
  String password = "1234";

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
          widget.destinationPage == "BalancePage"
              ? "Check Balance"
              : widget.destinationPage == "SendMoney"
                  ? "Send Money"
                  : widget.destinationPage == "BuyCrypto"
                      ? "Buy Crypto"
                      : widget.destinationPage == "SellCrypto"
                          ? "Sell Crypto"
                          : widget.destinationPage == "ConvertCrypto"
                              ? "Convert Crypto"
                              : "",
          style: GoogleFonts.getFont('Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textHi),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircularContainer(
                      text.length > 0 ? Colors.green : containerColor),
                  _buildCircularContainer(
                      text.length > 1 ? Colors.green : containerColor),
                  _buildCircularContainer(
                      text.length > 2 ? Colors.green : containerColor),
                  _buildCircularContainer(
                      text.length > 3 ? Colors.green : containerColor),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: VirtualKeyboard(
                height: 300,
                textColor: AppColors.textHi,
                fontSize: 18,
                type: VirtualKeyboardType.Numeric,
                onKeyPress: _onKeyPress,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
      ),
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      // Check if text length is less than 4 before appending characters
      if (text.length < 4) {
        text = text + (key.text ?? '');
        // Update flag when the first key is pressed
      }
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        default:
      }
    }
    // Update the screen
    setState(() {
      if (text == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.destinationPage == 'BalancePage'
                ? TransactionSuccess(destinationPage: "BalancePage")
                : widget.destinationPage == "SendMoney"
                    ? TransactionSuccess(
                        destinationPage: "SendMoney",
                        amount: widget.amount,
                      )
                    : widget.destinationPage == "BuyCrypto"
                        ? TransactionSuccess(
                            destinationPage: "BuyCrypto",
                            amount: widget.amount,
                          )
                        : widget.destinationPage == "SellCrypto"
                            ? TransactionSuccess(
                                destinationPage: "SellCrypto",
                                amount: widget.amount,
                              )
                            : widget.destinationPage == "ConvertCrypto"
                                ? TransactionSuccess(
                                    destinationPage: "ConvertCrypto",
                                    amount: widget.amount,
                                  )
                                : Container(),
          ),
        );
      }
    });
  }
}
