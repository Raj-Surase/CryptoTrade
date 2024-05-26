import 'package:cryptotrade/Screens/Pages/tradepage.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';

import 'package:flutter/material.dart';

class CryptoDropDown extends StatefulWidget {
  final String uniqueId;
  final Function(CryptoItem?) onCryptoSelected;

  const CryptoDropDown(
      {Key? key, required this.uniqueId, required this.onCryptoSelected})
      : super(key: key);

  @override
  State<CryptoDropDown> createState() => _CryptoDropDownState();
}

class _CryptoDropDownState extends State<CryptoDropDown> {
  final TextEditingController iconController = TextEditingController();
  final CoinController controller = Get.put(CoinController());

  CryptoItem? selectedCrypto;

  @override
  void initState() {
    super.initState();
    // Fetch locally stored coin data
    List<CryptoItem> cryptoItems = controller.coinList.map((coin) {
      return CryptoItem(
        name: "   " + coin.name,
        image: Image.network(
          coin.image,
          height: 24,
          width: 24,
        ),
      );
    }).toList();

    // Initialize selectedCrypto with a starting index
    int startingIndex = 0; // Change this to your desired starting index
    if (startingIndex >= 0 && startingIndex < cryptoItems.length) {
      setState(() {
        selectedCrypto = cryptoItems[startingIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CryptoItem>(
      controller: iconController,
      width: MediaQuery.of(context).size.width - 40,
      textStyle: TextStyle(
        color: AppColors.textHi,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      label: Text(
        "   " + selectedCrypto!.name,
        style: TextStyle(
          color: AppColors.textHi,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.surfaceFG,
        filled: true,
        suffixIconColor: AppColors.surfaceStroke,
        border: MaterialStateOutlineInputBorder.resolveWith(
          (states) => OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.textLo,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
        ),
        labelStyle: TextStyle(
          color: AppColors.textHi,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      enableSearch: false,
      enableFilter: false,
      initialSelection: selectedCrypto,
      requestFocusOnTap: true,
      leadingIcon: selectedCrypto?.image,
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => AppColors.surfaceFG,
        ),
        // maximumSize: MaterialStatePropertyAll(Size(600, 500)),
        // minimumSize: MaterialStatePropertyAll(Size(400, 500)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
        ),
        fixedSize: MaterialStatePropertyAll(
            Size(MediaQuery.of(context).size.width - 40, 400)),
      ),
      onSelected: (CryptoItem? crypto) {
        setState(() {
          selectedCrypto = crypto;
        });
        widget.onCryptoSelected(selectedCrypto);
      },
      dropdownMenuEntries:
          controller.coinList.map<DropdownMenuEntry<CryptoItem>>(
        (Coin coin) {
          return DropdownMenuEntry<CryptoItem>(
            value: CryptoItem(
              name: "   " + coin.name,
              image: Image.network(
                coin.image,
                height: 24,
                width: 24,
              ),
            ),
            label: "   " + coin.name,
            leadingIcon: Image.network(
              coin.image,
              height: 24,
              width: 24,
            ),
            labelWidget: Text(
              "   " + coin.name,
              style: TextStyle(
                color: AppColors.textHi,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
  // String getSelectedCryptoText(String uniqueId) {
  // switch (uniqueId) {
  //   case "drop1":
  //     return selectedCrypto1?.name ?? "Default Text";
  //   case "drop2":
  //     return selectedCrypto2?.name ?? "Default Text";
  //   // Add more cases for other uniqueIds if needed
  //   default:
  //     return "Default Text";
  // }
// }
}
