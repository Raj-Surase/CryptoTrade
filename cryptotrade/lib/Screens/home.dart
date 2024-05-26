import 'package:cryptotrade/Screens/cryptoscreen.dart';
import 'package:cryptotrade/Screens/portfolio.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // Define selectedIndex and initialize it

  void onButtonPressed(int index) {
    // Define the onButtonPressed method
    setState(() {
      selectedIndex =
          index; // Update the selectedIndex when a button is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedScreen;
    switch (selectedIndex) {
      case 0:
        selectedScreen = CryptoScreen();
        break;
      case 1:
        selectedScreen = PortfolioScreen();
        break;
      // Add more cases for additional screens if needed
      default:
        selectedScreen = CryptoScreen(); // Default to CryptoScreen
        break;
    }

    return Scaffold(
      body: selectedScreen,
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: AppColors.surfaceBG,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: AppColors.textHi,
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.currency_bitcoin_rounded,
            title: 'Crypto',
          ),
          BarItem(
            icon: Icons.history_rounded,
            title: 'Portfolio',
          ),
        ],
      ),
    );
  }
}
