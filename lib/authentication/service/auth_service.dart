// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/authentication/splash_screen.dart';
import 'package:fresh_day_dairy_project/common/widgets/bottom_nav_widget.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signUpWithEmailAndPasswordAuth(
    String email,
    String password,
    String userName,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        UserModel userModel = UserModel(
          userName: userName,
          email: email,
          passWord: password,
          isAdmin: false,
          milkDailyQuantity: 0,
          milkDailyAmount: 0,
          butterDailyQuantity: 0,
          butterDailyAmount: 0,
          butterMilkDailyQuantity: 0,
          butterMilkDailyAmount: 0,
          curdDailyQuantity: 0,
          curdDailyAmount: 0,
          gheeDailyQuantity: 0,
          gheeDailyAmount: 0,
          milkDailyTasks: [],
          butterDailyTasks: [],
          butterMilkDailyTasks: [],
          curdDailyTasks: [],
          gheeDailyTasks: [],
        );
        firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toJson());
        log('Success');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavWidget(),
        ));
      } else {
        log("Error");
      }
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
  }

  // Future<User?> loginAuth(
  //   String email,
  //   String password,
  //   BuildContext context,
  // ) async {
  //   try {
  //     UserCredential userCredential =
  //         await firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (firebaseAuth.currentUser!.emailVerified) {
  //       log('Sucess');
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => const BottomNavWidget(),
  //       ));
  //       return userCredential.user;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e);
  //   }
  //   return null;
  // }

  Future<User?> loginAuth(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // Step 1: Check if user exists in Firestore
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      log(querySnapshot.toString());

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first.data();

        String storedPassword = userDoc['passWord'];
        log(storedPassword);

        // Step 3: Compare the entered password with the stored password
        if (storedPassword == password) {
          // Step 4: Log in using Firebase Auth

          UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const BottomNavWidget(),
          ));
          return userCredential.user;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password is incorrect.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User does not exist. Please sign up.")),
        );
      }
    } on FirebaseAuthException catch (e) {
      log('Error during login: $e');
      throw Exception(e);
    }
    return null;
  }

  // Future<User?> loginAuth(
  //   String email,
  //   String password,
  //   BuildContext context,
  // ) async {
  //   try {
  //     // Sign in with email and password
  //     UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     await Future.delayed(const Duration(seconds: 2));
  //     await firebaseAuth.currentUser?.reload();
  //     User? refreshedUser = firebaseAuth.currentUser;
  //     if (refreshedUser?.emailVerified ?? false) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const BottomNavWidget(),
  //         ),
  //       );
  //       return credential.user;
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const AlertDialog(
  //             title: Text('Email Not Verified'),
  //             content: Text(
  //               'Please verify your email before logging in. Check your inbox for the verification email.',
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Log the error for debugging
  //     log('Error: $e');

  //     // Display a dialog if an authentication error occurs
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text('Error'),
  //           content: Text('The Email or Password you entered is incorrect.'),
  //         );
  //       },
  //     );
  //   }
  //   return null; // Return null if login fails
  // }

  Future<UserModel?> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<void> logoutAuth(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      log('Successfully logged out');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      log('Logout Error: ${e.message}');
    } catch (e) {
      log('Unexpected Error: $e');
    }
  }
}
