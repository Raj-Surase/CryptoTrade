import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  const QRCodeGenerator({
    super.key,
    required this.globalKey,
    required this.mobile,
    required this.fname,
  });

  final GlobalKey<State<StatefulWidget>> globalKey;
  final String mobile;
  final String fname;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceFG,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset(
                'assets/UPI-White.png',
                height: 100,
                width: 200,
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.width / 1.4,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.textLo,
                ),
                child: Center(
                  child: QrImageView(
                    data:
                        'upi://pay?pa=$mobile@axl&pn=$fname&mc=0000&mode=02&purpose=00',
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.width / 1.5,
                    backgroundColor: AppColors.textLo,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "$mobile@axl",
                style: GoogleFonts.getFont(
                  'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textHi,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
