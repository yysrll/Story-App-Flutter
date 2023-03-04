import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/api/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper extends ChangeNotifier {
  static const String loginKey = 'stateKey';
  static const String tokenKey = 'tokenKey';
  static const String nameKey = 'nameKey';

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginKey) ?? false;
  }

  Future<bool> login(LoginResultResponse? user) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(tokenKey, user!.token.toString());
    preferences.setString(nameKey, user.name.toString());
    return preferences.setBool(loginKey, true);
  }

  Future<String> getUserName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey) ?? '';
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey) ?? '';
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(tokenKey, '');
    preferences.setString(nameKey, '');
    return preferences.setBool(loginKey, false);
  }
}
