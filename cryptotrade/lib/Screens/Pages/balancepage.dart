import 'package:cryptotrade/Screens/Modules/pinscreen.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
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
          "Check Balance",
          style: GoogleFonts.getFont('Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textHi),
        ),
      ),
      body: PinScreen(
        destinationPage: "BalancePage",
      ),
    );
  }
}
