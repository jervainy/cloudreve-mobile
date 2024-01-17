import 'package:cloudreve_mobile/common/http.dart';
import 'package:cloudreve_mobile/models/token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static late SharedPreferences _prefs;
  static late TokenUserData tokenData;

  static bool release = false;

  static const _prefsServerKey = '_prefs_server';
  static const _prefsTokenValue = '_prefs_token';

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    HttpDio.init();
  }

  static String? readServerAddress() {
    return _prefs.getString(_prefsServerKey);
  }

  static void saveServerAddress(String address) {
    final url = address;
    _prefs.setString(_prefsServerKey, url);
    HttpDio.setBaseurl(url);
  }

  static String? readToken() {
    return _prefs.getString(_prefsTokenValue);
  }

  static void saveToken(String token) {
    _prefs.setString(_prefsTokenValue, token);
  }

  static void setTokenData(TokenUserData data) {
    tokenData = data;
  }

}