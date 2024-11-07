import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';

class ProductController extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Set<String> selectedItems = {};
  notify() {
    notifyListeners();
  }

  // Stream<List<UserModel>> getAllUsers() {
  //   return FirebaseFirestore.instance.collection('users').snapshots().map(
  //         (snapshot) => snapshot.docs
  //             .map((doc) => UserModel.fromJson(doc.data()))
  //             .toList(),
  //       );
  // }

  Stream<List<UserModel>> getAllUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
      (snapshot) {
        List<UserModel> users = snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .where((user) => user.isAdmin != true) // Exclude admins
            .toList();

        return users;
      },
    );
  }

  Future<void> addDailyTask(
      String email, String taskCatagory, BuildContext context) async {
    String date = dateController.text.trim();
    String amount = amountController.text.trim();
    String quantity = quantityController.text.trim();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (date.isNotEmpty || amount.isNotEmpty || quantity.isNotEmpty) {
        DailyTasks dailyTasks = DailyTasks(
          id: id,
          date: date,
          amount: amount,
          quantity: quantity,
        );
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String userId = querySnapshot.docs.first.id;
          await firebaseFirestore.collection('users').doc(userId).update({
            taskCatagory: FieldValue.arrayUnion([dailyTasks.toJson()])
          });
          log('success');
          dateController.clear();
          amountController.clear();
          quantityController.clear();

          Navigator.of(context).pop();
        } else {
          log('No user found with email: $email');
        }
      } else {
        log('Fillout all the forms');
      }
    } catch (e) {
      log('Error adding daily task: $e');
    }
  }

  Future<void> clearAllMilkDailyTasks(String email) async {
    try {
      // Find the user by their email
      final userSnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs.first;

        // Clear the milkDailyTasks list
        await userDoc.reference.update({
          'milkDailyTasks': [], // Set the list to an empty array
        });

        log('All milk daily tasks cleared successfully.');
        notifyListeners(); // Notify listeners if the UI needs to be updated
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error clearing milk daily tasks: $e');
    }
  }

  Stream<UserModel?> getUserByEmail(String email) {
    return firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromJson(snapshot.docs.first.data());
      }
      return null; // Return null if no user is found
    });
  }
}
