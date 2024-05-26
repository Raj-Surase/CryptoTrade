import 'package:cryptotrade/Screens/Modules/actionbutton.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionTabs extends StatelessWidget {
  const TransactionTabs({
    required this.fIcon,
    required this.fText,
    required this.fPage,
    required this.sIcon,
    required this.sText,
    required this.sPage,
    required this.tIcon,
    required this.tText,
    required this.tPage,
    super.key,
  });

  final IconData fIcon;
  final String fText;
  final String fPage;

  final IconData sIcon;
  final String sText;
  final String sPage;

  final IconData tIcon;
  final String tText;
  final String tPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceFG,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButton(
                  iconName: fIcon, iconText: fText, destinationPage: fPage),
              ActionButton(
                  iconName: sIcon, iconText: sText, destinationPage: sPage),
              ActionButton(
                  iconName: tIcon, iconText: tText, destinationPage: tPage),
            ],
          ),
        ),
      ),
    );
  }
}
