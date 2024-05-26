import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class APICallModel {
  // Get API
  static Future<http.Response> getAPICallMethod(String apiUrl) async {
    Uri url = Uri.parse(apiUrl);
    var response;
    try {
      response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
    } catch (e) {
      // print("response => ${e.toString()}");
      // ShowSnackBar.showSnackBar(
      //     text: AppString.errorMessage,
      //     snackBarBackgroundColor: AppColors.redColor);
    }
    return response;
  }

  // Post API
  static Future<http.Response> postAPICallMethod(
      String apiUrl, Map<String, dynamic> body) async {
    Uri url = Uri.parse(apiUrl);
    var response;
    Map<String, String> headers = {
      "EmailID": "rajsurase3@gmail..com",
      "Content-Type": "application/json"
    };
    try {
      response = await http.post(url, body: jsonEncode(body), headers: headers);
      print(response);
    } catch (e) {
      print("response => ${e.toString()}");
      // ShowSnackBar.showSnackBar(
      //     text: AppString.errorMessage,
      //     snackBarBackgroundColor: AppColors.redColor);
    }
    return response;
  }

  // delete API
  static Future<http.Response> deleteAPICallMethod(String apiUrl) async {
    Uri url = Uri.parse(apiUrl);
    var response;
    Map<String, String> headers = {
      "EmailID": "rajsurase3@gmail..com",
    };
    try {
      response = await http.delete(url, headers: headers);
      print(response);
    } catch (e) {
      print("response => ${e.toString()}");
      // ShowSnackBar.showSnackBar(
      //     text: AppString.errorMessage,
      //     snackBarBackgroundColor: AppColors.redColor);
    }
    return response;
  }

  static Future<void> storeDataLocally(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  static Future<dynamic> getDataLocally(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}
