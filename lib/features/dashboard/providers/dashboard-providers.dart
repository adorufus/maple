import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maple/utils/colors.dart';

class DashboardProviders with ChangeNotifier {
  Color _appBarColor = MapleColor.indigo;
  int _navIndex = 0;
  String _selectedType = '';

  Color get appBarColor => _appBarColor;
  int get navIndex => _navIndex;
  String get selectedType => _selectedType;

  void setColor(Color color) {
    _appBarColor = color;
    notifyListeners();
  }

  void setNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }

  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }
}