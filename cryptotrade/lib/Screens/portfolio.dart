import 'package:cryptotrade/Screens/Modules/balance.dart';
import 'package:cryptotrade/Screens/Pages/loginpage.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/database_connection.dart';
import 'package:cryptotrade/main.dart';
import 'package:flutter/material.dart';
import 'package:cryptotrade/Screens/chart.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/charts_controller.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final String? username = currentUser;
  // Define a key for the shared preferences
  final String _cacheKey = 'coin_container_cache';

  // Function to save data to cache
  Future<void> _saveDataToCache(List<Coin> coins) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = coinToJson(coins);
    prefs.setString(_cacheKey, jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Balance(),
        SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseHelper().getRecentTransactionsByUsername(username!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No transactions found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final transaction = snapshot.data![index];
                    return ListTile(
                      title: Text(
                        'Amount: ${transaction['amount']}',
                        style: TextStyle(
                          color: AppColors.textHi,
                        ),
                      ),
                      subtitle: Text(
                        'Date: ${transaction['date']}',
                        style: TextStyle(
                          color: AppColors.textHi,
                        ),
                      ),
                      // Add more details as needed
                    );
                  },
                );
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.redMain,
          ),
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                "LOGOUT",
                style: TextStyle(
                    color: AppColors.textHi,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
        ),
      ],
    );
  }
}
