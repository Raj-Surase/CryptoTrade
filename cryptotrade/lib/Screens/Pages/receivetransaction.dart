import 'dart:io';

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import 'package:cryptotrade/Screens/Modules/qrcode.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class ReceiveTransaction extends StatefulWidget {
  const ReceiveTransaction({super.key});

  @override
  State<ReceiveTransaction> createState() => _ReceiveTransactionState();
}

class _ReceiveTransactionState extends State<ReceiveTransaction> {
  final String mobile = '8010940295';
  String fname = 'Raj Surase'.replaceAll(' ', '%20');

  GlobalKey globalKey = GlobalKey();

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      await ImageGallerySaver.saveImage(pngBytes);
      Fluttertoast.showToast(
        msg: "Image saved successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.surfaceStroke,
        textColor: AppColors.textHi,
        fontSize: 18,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(pngBytes);

      // Share the file using share_plus package
      await Share.shareFiles(['${tempDir.path}/screenshot.png'],
          text: 'Check out this image');

      Fluttertoast.showToast(
        msg: "Image shared successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.surfaceStroke,
        textColor: AppColors.textHi,
        fontSize: 18,
      );
    } catch (e) {
      print(e.toString());
    }
  }

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
          "Receive Money",
          style: GoogleFonts.getFont('Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textHi),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: Column(
          children: [
            QRCodeGenerator(globalKey: globalKey, mobile: mobile, fname: fname),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.surfaceStroke,
                      ),
                      child: TextButton.icon(
                        onPressed: _captureAndSavePng,
                        icon: Icon(
                          Icons.download_rounded,
                          size: 24,
                          color: AppColors.primaryMain,
                        ),
                        label: Text(
                          "Download",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textHi,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.surfaceStroke,
                      ),
                      child: TextButton.icon(
                        onPressed: _captureAndSharePng,
                        icon: Icon(
                          Icons.share_rounded,
                          size: 24,
                          color: AppColors.primaryMain,
                        ),
                        label: Text(
                          "Share",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textHi,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
