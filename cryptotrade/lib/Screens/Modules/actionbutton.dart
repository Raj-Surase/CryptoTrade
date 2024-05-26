import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    super.key,
    required this.iconName,
    required this.iconText,
    required this.destinationPage,
  });

  final IconData iconName;
  final String iconText;
  final String destinationPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.surfaceStroke,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(
              iconName,
              color: AppColors.primaryOnSurface,
              size: 45,
              // weight: 60,
            ),
            onPressed: () {
              Navigator.pushNamed(context, destinationPage);
            },
          ),
        ),
        Container(
          width: 80,
          padding: EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            // color: AppColors.primary100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              iconText,
              style: TextStyle(
                  color: AppColors.textHi,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // ),
        ),
      ],
    );
  }
}
