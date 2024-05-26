import 'package:cryptotrade/Screens/home.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/database_connection.dart';
import 'package:cryptotrade/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionSuccess extends StatefulWidget {
  const TransactionSuccess({
    required this.destinationPage,
    this.amount, // Add amount parameter
    Key? key,
  }) : super(key: key);

  final String destinationPage;
  final String? amount;
  @override
  State<TransactionSuccess> createState() => _TransactionSuccessState();
}

class _TransactionSuccessState extends State<TransactionSuccess> {
  // Define amount parameter
  @override
  Widget build(BuildContext context) {
    // Define the transaction type based on the destination page
    String transactionType = widget.destinationPage == 'BuyCrypto' ||
            widget.destinationPage == 'SellCrypto'
        ? widget.destinationPage
        : '';

    return FutureBuilder<int>(
      future: _getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          int userId = snapshot.data!;

          // Insert payment history into the database
          DatabaseHelper().insertPayment(
              userId, double.parse(widget.amount!), transactionType);

          // Determine whether to subtract or add the amount from/to the balance
          if (transactionType == 'BuyCrypto') {
            // Subtract the amount from the balance
            DatabaseHelper().updateBalanceByPage(
                widget.destinationPage, userId, -double.parse(widget.amount!));
          } else if (transactionType == 'SellCrypto') {
            // Add the amount to the balance
            DatabaseHelper().updateBalanceByPage(
                widget.destinationPage, userId, double.parse(widget.amount!));
          }

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
                                ? "SellCrypto"
                                : widget.destinationPage == "ConvertCrypto"
                                    ? "ConvertCrypto"
                                    : "",
                style: GoogleFonts.getFont('Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textHi),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    'assets/payment-done.png',
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    widget.destinationPage == "BalancePage"
                        ? "Available Balance"
                        : widget.destinationPage == "SendMoney"
                            ? "Payment Successful"
                            : widget.destinationPage == "BuyCrypto"
                                ? "Crypto Transaction Successful"
                                : widget.destinationPage == "SellCrypto"
                                    ? "Crypto Transaction Successful"
                                    : widget.destinationPage == "ConvertCrypto"
                                        ? "Crypto Transaction Successful"
                                        : "",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHi,
                    ),
                  ),
                  FutureBuilder<double>(
                    future: _fetchBalance(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Show error if any
                      } else {
                        double balance = snapshot.data ?? 0.0;
                        return Text(
                          widget.destinationPage == "BalancePage"
                              ? "₹$balance"
                              : "${widget.amount ?? '0.0'}₹",
                          style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textHi,
                          ),
                        );
                      }
                    },
                  ),
                  Spacer(), // Added Spacer to push the TextButton to the bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.greenMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          child: Center(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textHi,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<int> _getUserId() async {
    // Fetch the user ID from the DatabaseHelper
    // Replace this with your actual implementation to get the user ID
    return await DatabaseHelper()
        .getUserId(currentUser!); // Example method to get user ID
  }

  Future<double> _fetchBalance(int userId) async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      double balance = await dbHelper.getBalance(userId);
      return balance;
    } catch (e) {
      print('Error fetching balance: $e');
      return 0.0;
    }
  }
}
