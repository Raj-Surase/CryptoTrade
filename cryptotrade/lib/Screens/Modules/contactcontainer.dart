import 'package:cryptotrade/Screens/Pages/transferpage.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';

SliverChildBuilderDelegate ContactsContainer(List<Contact>? _filteredContacts) {
  return SliverChildBuilderDelegate(
    (context, i) {
      final contact = _filteredContacts[i];
      late String number;
      return InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransferPage(name: contact.displayName, number: number),
            ),
          );
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceFG,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.textLo,
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: AppColors.textLo, width: 5),
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.surfaceFG,
                            size: 30,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contact.displayName,
                            style: GoogleFonts.getFont(
                              'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textHi,
                            ),
                          ),
                          FutureBuilder<Contact?>(
                            future: FlutterContacts.getContact(contact.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('');
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.phones.isNotEmpty
                                      ? number =
                                          snapshot.data!.phones.first.number
                                      : 'Phone number not available',
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textLo,
                                  ),
                                );
                              } else {
                                return Text('Loading...');
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    childCount: _filteredContacts!.length,
  );
}
