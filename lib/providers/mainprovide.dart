import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class MainProvide with ChangeNotifier {
  Router mainrouter;
  set MainRouter(Router router) {
    mainrouter = router;
    notifyListeners();
  }
}
