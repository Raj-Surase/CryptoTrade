import 'package:cryptotrade/Screens/Modules/balance.dart';
import 'package:cryptotrade/Screens/Modules/coincontainer.dart';
import 'package:cryptotrade/Screens/Modules/transactiontabs.dart';
import 'package:cryptotrade/constants/app_colors.dart';
import 'package:cryptotrade/controllers/coin_controller.dart';
import 'package:cryptotrade/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'package:permission_handler/permission_handler.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final CoinController controller = Get.put(CoinController());
  final TextEditingController _searchController = TextEditingController();

  late List<Coin> _filteredCoinNames = _allCoinNames;
  late List<Coin> _allCoinNames;

  // Define a key for the shared preferences
  final String _cacheKey = 'crypto_cache';

  PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;
  PermissionStatus _contactsPermissionStatus = PermissionStatus.denied;
  PermissionStatus _storagePermissionStatus = PermissionStatus.denied;

  Future<void> requestCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    setState(() {
      _cameraPermissionStatus = status;
    });
  }

  Future<void> requestContactsPermission() async {
    final PermissionStatus status = await Permission.contacts.request();
    setState(() {
      _contactsPermissionStatus = status;
    });
  }

  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();
    setState(() {
      _storagePermissionStatus = status;
    });
  }

  void requestAllPermissions() async {
    await requestCameraPermission();
    await requestContactsPermission();
    await requestStoragePermission();
  }

  @override
  void initState() {
    super.initState();

    requestAllPermissions();

    _allCoinNames = controller.coinList;

    // Load data from cache during initialization
    _loadDataFromCache();

    // If cache is empty or expired, fetch data from the API
    if (_allCoinNames.isEmpty) {
      _fetchDataFromAPI();
    } else {
      _filteredCoinNames = _allCoinNames;
    }
  }

  // Function to load data from cache
  Future<void> _loadDataFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = prefs.getString(_cacheKey) ?? '';

    if (cachedData.isNotEmpty) {
      List<Coin> cachedCoins = coinFromJson(cachedData);
      setState(() {
        _allCoinNames = cachedCoins;
        _filteredCoinNames = cachedCoins;
      });
    }
  }

  // Function to save data to cache
  Future<void> _saveDataToCache(List<Coin> coins) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = coinToJson(coins);
    prefs.setString(_cacheKey, jsonData);
  }

  // Function to fetch data from the API
  Future<void> _fetchDataFromAPI() async {
    try {
      await controller.fetchCoin(); // Assuming fetchCoin updates coinList

      // Save fetched data to cache
      _saveDataToCache(controller.coinList);
    } catch (e) {
      print('Error fetching data from API: $e');
    } finally {
      setState(() {
        _filteredCoinNames = _allCoinNames;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Balance(),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "UPI",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xFFFAFBFC),
                        ),
                      ),
                    ),
                    TransactionTabs(
                      fIcon: Icons.file_upload_outlined,
                      fText: "Send",
                      fPage: "SendUPI",
                      sIcon: Icons.file_download_outlined,
                      sText: "Receive",
                      sPage: "ReceiveUPI",
                      tIcon: Icons.account_balance_rounded,
                      tText: "Balance",
                      tPage: "BalanceUPI",
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "Crypto",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xFFFAFBFC),
                        ),
                      ),
                    ),
                    TransactionTabs(
                      fIcon: Icons.south_rounded,
                      fText: "Buy",
                      fPage: "BuyCrypto",
                      sIcon: Icons.north_rounded,
                      sText: "Sell",
                      sPage: "SellCrypto",
                      tIcon: Icons.swap_vert_rounded,
                      tText: "Convert",
                      tPage: "ConvertCrypto",
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "Charts",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xFFFAFBFC),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                _filteredCoinNames = _allCoinNames
                                    .where((Coin coin) => coin.name
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverList(
                  delegate: CoinContainer(_filteredCoinNames),
                ),
              ],
            ),
    );
  }
}
