import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';

class CurdProductController extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Set<String> selectedItems = {};

  void notify() {
    notifyListeners();
  }

  Stream<List<UserModel>> getAllUsers() {
    return firebaseFirestore.collection('users').snapshots().map((snapshot) {
      List<UserModel> users = snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.isAdmin != true) // Exclude admins
          .toList();

      return users;
    });
  }

  Stream<List<UserModel>> getUserByEmail(String email) {
    return firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return [UserModel.fromJson(snapshot.docs.first.data())];
      }
      return [];
    });
  }

  Future<void> updateUser(UserModel user) async {
    try {
      var userQuery = firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: user.email);

      var querySnapshot = await userQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userDocRef = userDoc.reference;

        await userDocRef.update({
          'curdDailyTasks': user.curdDailyTasks,
        });

        log('User updated successfully');
      } else {
        log('User not found');
      }
    } catch (e) {
      log('Error updating user: $e');
    }
  }

  Future<void> updateUserEnterableTask(
      String email, String task, int newValue) async {
    try {
      var userQuery = firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email);

      var querySnapshot = await userQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userDocRef = userDoc.reference;

        await userDocRef.update({
          task: newValue,
        });

        log('User task "$task" updated successfully');
      } else {
        log('User not found');
      }
    } catch (e) {
      log('Error updating user task "$task": $e');
    }
  }

  Future<void> clearAllCurdDailyTasks(String email) async {
    try {
      final userSnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs.first;

        await userDoc.reference.update({
          'curdDailyTasks': [],
          'curdDailyAmount': 0,
          'curdDailyQuantity': 0,
        });

        log('All curd daily tasks cleared successfully for $email.');
        notifyListeners();
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error clearing curd daily tasks: $e');
    }
  }

  Future<void> saveAllUsersCurdData() async {
    try {
      // Fetch all users from the 'users' collection
      final usersSnapshot = await firebaseFirestore.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        final email = userDoc['email'] ?? 'Unknown Email';
        final userName = userDoc['userName'] ?? 'Unknown User';
        final curdDailyAmount = userDoc['curdDailyAmount'] ?? 0;
        final curdDailyQuantity = userDoc['curdDailyQuantity'] ?? 0;
        final curdDailyTasks = userDoc['curdDailyTasks'] ?? [];
        final previousCurdBalance =
            userDoc.data().containsKey('previousCurdBalance')
                ? userDoc['previousCurdBalance']
                : 0; // Use default value if the field is missing

        if (curdDailyTasks.isNotEmpty) {
          // Create a reference for the new document in 'all_time_curd_data' collection
          final allTimeDataRef =
              firebaseFirestore.collection('all_time_curd_data').doc();

          // Prepare the data to be saved
          final curdData = {
            'userName': userName,
            'email': email,
            'curdDailyAmount': curdDailyAmount,
            'curdDailyQuantity': curdDailyQuantity,
            'curdDailyTasks': curdDailyTasks,
            'previousCurdBalance': previousCurdBalance,
            'timestamp': FieldValue.serverTimestamp(),
          };

          // Save the data
          await allTimeDataRef.set(curdData);

          log('Curd data for user $email saved successfully.');
        } else {
          log('No curd data to save for user $email.');
        }
      }
    } catch (e) {
      log('Error saving curd data: $e');
    }
  }

  Future<void> deleteAllTimeCurdData(String documentId) async {
    try {
      var documentRef =
          firebaseFirestore.collection('all_time_curd_data').doc(documentId);

      await documentRef.delete();

      log('All-time curd data with ID $documentId deleted successfully.');
    } catch (e) {
      log('Error deleting all-time curd data: $e');
    }
  }

  Future<void> clearCurdTasksForAllUsers(BuildContext context) async {
    try {
      bool confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirm Task Reset"),
              content: const Text(
                "Are you sure you want to clear the 'Curd Daily Tasks' for all users? This action cannot be undone. Make sure to save the data before proceeding.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Clear Tasks"),
                ),
              ],
            ),
          ) ??
          false;

      if (confirm) {
        QuerySnapshot snapshot =
            await firebaseFirestore.collection('users').get();
        for (var doc in snapshot.docs) {
          await doc.reference.update({
            'curdDailyTasks': [],
            'curdDailyAmount': 0,
            'curdDailyQuantity': 0,
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("All curd daily tasks have been cleared.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
