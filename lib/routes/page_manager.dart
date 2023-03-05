import 'dart:async';

import 'package:flutter/material.dart';

class PageManager<String> extends ChangeNotifier {
  late Completer<String> _completer;

  Future<String> waitForResult() async {
    _completer = Completer<String>();
    return _completer.future;
  }

  void returnData(String data) {
    _completer.complete(data);
  }
}
