import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maple/utils/colors.dart';

class DashboardProviders with ChangeNotifier {
  Color _appBarColor = MapleColor.indigo;
  int _navIndex = 0;
  String _selectedType = '';
  String _username = '';
  String _fullName = '';
  String _mapleIcon = 'assets/images/logo-maple-kecil.png';

  Color get appBarColor => _appBarColor;
  int get navIndex => _navIndex;
  String get selectedType => _selectedType;
  String get username => _username;
  String get fullName => _fullName;
  String get mapleIcon => _mapleIcon;

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

  void setUsername(String thisUsername) {
    _username = thisUsername;
    notifyListeners();
  }

  void setFullName(String thisFullname) {
    _fullName = thisFullname;
    notifyListeners();
  }

  void setMapleIcon(String path) {
    _mapleIcon = path;
    notifyListeners();
  }
}