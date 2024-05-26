import 'package:cryptotrade/Screens/Modules/contactcontainer.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Contact>? _contacts;
  List<Contact>? _filteredContacts;
  bool _permissionDenied = false;
  final TextEditingController _searchController = TextEditingController();

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlash = false;

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  void initState() {
    super.initState();
    // _filteredContacts = contacts;
    _fetchContacts();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future _fetchContacts() async {
    // if (!await FlutterContacts.requestPermission(readonly: true)) {
    //   setState(() => _permissionDenied = true);
    // } else {
    final contacts = await FlutterContacts.getContacts();
    setState(() {
      _contacts = contacts;
      _filteredContacts = contacts;
    });
    // }
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: _buildQrView(context),
                ),
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.surfaceFG),
                    child: IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        isFlash = !isFlash;
                        setState(() {});
                      },
                      icon: Icon(
                        isFlash
                            ? Icons.flash_on_rounded
                            : Icons.flash_off_rounded,
                        color: AppColors.textHi,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.surfaceFG),
                    child: IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cameraswitch_rounded,
                        color: AppColors.textHi,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.surfaceFG,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Color(0xFFFAFBFC),
                          fontSize: 16,
                        ),
                        cursorColor: AppColors.textLo,
                        decoration: const InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Color(0xFFBDBEC0)),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              size: 35,
                              color: Color(0xFF3269FC),
                            )),
                        onChanged: (value) {
                          setState(() {
                            _filteredContacts = _contacts
                                ?.where((Contact contact) => contact.displayName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])),
          if (_permissionDenied)
            SliverFillRemaining(
              child: Center(
                  child: Text(
                'Permission denied.',
                style: GoogleFonts.getFont(
                  'Roboto',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: AppColors.redMain,
                ),
              )),
            )
          else if (_contacts == null)
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_filteredContacts == null)
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            SliverList(
              delegate: ContactsContainer(_filteredContacts),
            ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 40,
              )
            ]),
          ),
        ],
      ),
      // ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
