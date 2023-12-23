import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({this.milliseconds = 500});

  void run(VoidCallback callback) {
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), callback);
  }
}
