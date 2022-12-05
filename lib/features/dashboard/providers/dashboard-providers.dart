import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maple/utils/colors.dart';

class DashboardProviders with ChangeNotifier {
  Color _appBarColor = MapleColor.indigo;
  int _navIndex = 0;

  Color get appBarColor => _appBarColor;
  int get navIndex => _navIndex;

  void setColor(Color color) {
    _appBarColor = color;
    notifyListeners();
  }

  void setNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }
}