import 'package:cryptotrade/Screens/Modules/pinscreen.dart';
import 'package:cryptotrade/Screens/Pages/loginpage.dart';
import 'package:cryptotrade/Screens/Pages/receivetransaction.dart';
import 'package:cryptotrade/Screens/Pages/tradepage.dart';
import 'package:cryptotrade/Screens/Pages/transactionpage.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'Screens/home.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

String? currentUser;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomeScreen(),
        'BuyCrypto': (context) => BuyCrypto(screen: "Buy"),
        'SellCrypto': (context) => BuyCrypto(screen: "Sell"),
        'ConvertCrypto': (context) => BuyCrypto(screen: "Convert"),
        'SendUPI': (context) => TransactionPage(),
        'ReceiveUPI': (context) => ReceiveTransaction(),
        'BalanceUPI': (context) => PinScreen(destinationPage: "BalancePage"),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          labelMedium: GoogleFonts.getFont(
            'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textHi,
          ),
          labelSmall: GoogleFonts.getFont(
            'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textHi,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceBG,
          elevation: 0,
          // toolbarHeight: 100,
          titleTextStyle: GoogleFonts.getFont(
            'Coiny',
            fontSize: 40,
            fontWeight: FontWeight.w400,
            color: AppColors.textHi,
          ),
        ),
        scaffoldBackgroundColor: AppColors.surfaceBG,
      ),
      home: LoginPage(),
    );
  }
}
