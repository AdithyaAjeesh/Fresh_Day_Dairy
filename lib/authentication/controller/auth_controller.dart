// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/login_screen_email.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/authentication/service/auth_service.dart';
import 'package:fresh_day_dairy_project/common/widgets/bottom_nav_widget.dart';

class AuthController extends ChangeNotifier {
  AuthService authService = AuthService();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  Future<void> signupWithEmailAndPassword(BuildContext context) async {
    String userName = userNameController.text.trim();
    String email = emailController.text.trim();
    String passWord = passWordController.text.trim();
    if (userName.isNotEmpty || email.isNotEmpty || passWord.isNotEmpty) {
      await authService.signUpWithEmailAndPasswordAuth(
        email,
        passWord,
        userName,
        context,
      );
    } else {
      log('Fillout the Form');
    }
  }

  Future<void> loginFunction(BuildContext context) async {
    String password = passWordController.text;
    String email = emailController.text;
    if (password.isNotEmpty || email.isNotEmpty) {
      authService.loginAuth(email, password, context);
    } else {
      log('Fillout the form');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    return await authService.getCurrentUser();
  }

  Future<void> checkLoggedInFunction(BuildContext context) async {
    final currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavWidget(),
        ));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreenEmail(),
        ));
      });
    }
  }

  Future<void> logoutFunction(BuildContext context) async {
    authService.logoutAuth(context);
    userNameController.clear();
    passWordController.clear();
    emailController.clear();
    notifyListeners();
  }
}
