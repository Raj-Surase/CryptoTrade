import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/database_connection.dart';
import 'package:cryptotrade/main.dart';
import 'package:flutter/material.dart';
// Import your DatabaseHelper class

class Balance extends StatelessWidget {
  const Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.surfaceFG,
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        // height: 80,
        child: FutureBuilder<double>(
          future: _fetchBalance(), // Call the method to fetch balance
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              double balance = snapshot.data ?? 0.0;
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Crypto Balance",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFAFBFC),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "₹$balance", // Display the fetched balance here
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFAFBFC),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Method to fetch balance
  Future<double> _fetchBalance() async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      String? username =
          currentUser; // Provide the username for which you want to fetch the balance
      double balance = await dbHelper.getBalanceByUsername(username!);
      return balance;
    } catch (e) {
      print('Error fetching balance: $e');
      return 0.0;
    }
  }
}
