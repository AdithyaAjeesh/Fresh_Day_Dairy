import 'package:flutter/material.dart';

class BottomNavController extends ChangeNotifier {
  int currentIndex = 0;
  



 

  void navigateToNextScreen(index) {
    currentIndex = index;
    notifyListeners();
  }
}
