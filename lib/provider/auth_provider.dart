import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/api/api_service.dart';
import 'package:flutter_story_app/data/pref/pref_helper.dart';

class AuthProvider extends ChangeNotifier {
  late ApiService api;
  late PrefHelper pref;

  bool isLoggedIn = false;

  AuthProvider() {
    api = ApiService();
    pref = PrefHelper();
    isLogin();
  }

  bool isLoadingLogin = false;
  bool isLoadingRegister = false;
  bool isLoadingLogout = false;

  String _message = '';
  String get message => _message;

  Future<void> isLogin() async {
    isLoggedIn = await pref.isLoggedIn();
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoadingLogin = true;
      notifyListeners();

      final result = await api.login(email, password);
      if (!(result.error ?? true)) {
        await pref.login(result.loginResult);
      }
      isLoggedIn = await pref.isLoggedIn();
    } catch (e) {
      _message = e.toString();
      notifyListeners();
    } finally {
      isLoadingLogin = false;
      notifyListeners();
    }
    return isLoggedIn;
  }

  Future<bool> logout() async {
    try {
      isLoadingLogout = true;
      notifyListeners();

      await pref.logout();
      isLoggedIn = await pref.isLoggedIn();
    } catch (e) {
      _message = e.toString();
      notifyListeners();
    } finally {
      isLoadingLogout = false;
      notifyListeners();
    }
    return !isLoggedIn;
  }

  Future<bool> register(String name, String email, String password) async {
    bool isRegistered = false;
    try {
      isLoadingRegister = true;
      notifyListeners();

      final result = await api.register(name, email, password);
      _message = result.message.toString();
      isRegistered = !(result.error ?? true);
    } catch (e) {
      _message = e.toString();
      notifyListeners();
    } finally {
      isLoadingRegister = false;
      notifyListeners();
    }
    return isRegistered;
  }
}
