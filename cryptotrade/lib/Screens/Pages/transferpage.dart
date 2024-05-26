import 'package:cryptotrade/Screens/Modules/pinscreen.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({required this.name, required this.number, super.key});
  final String name;
  final String number;

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late final TextEditingController _textEditingController;
  final TextEditingController _textEditingController2 =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.number);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController2.dispose();
    super.dispose();
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
          "Send Money",
          style: GoogleFonts.getFont('Roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textHi),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mobile number",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xFFFAFBFC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.surfaceFG,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: TextField(
                    controller: _textEditingController,
                    style: const TextStyle(
                      color: Color(0xFFFAFBFC),
                      fontSize: 16,
                    ),
                    cursorColor: AppColors.textLo,
                    decoration: const InputDecoration(
                        hintText: 'Mobile number',
                        hintStyle: TextStyle(color: Color(0xFFBDBEC0)),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.person_rounded,
                          size: 35,
                          color: Color(0xFF3269FC),
                        )),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Text(
              "Amount",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xFFFAFBFC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.surfaceFG,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: TextField(
                    controller: _textEditingController2,
                    style: const TextStyle(
                      color: Color(0xFFFAFBFC),
                      fontSize: 16,
                    ),
                    cursorColor: AppColors.textLo,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')), // Allow only numeric input
                    ],
                    keyboardType:
                        TextInputType.phone, // Set keyboard type to phone
                    decoration: const InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Color(0xFFBDBEC0)),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.currency_rupee_rounded,
                          size: 35,
                          color: Color(0xFF3269FC),
                        )),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinScreen(
                          destinationPage: "SendMoney",
                          amount: _textEditingController2.text,
                        ),
                      ),
                    );
                  },
                  backgroundColor: AppColors.greenMain,
                  label: Text(
                    'Transfer',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFFFAFBFC),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // );
    );
  }
}
