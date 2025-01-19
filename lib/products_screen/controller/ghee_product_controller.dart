// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';

// class GheeProductController extends ChangeNotifier {
//   TextEditingController dateController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   Set<String> selectedItems = {};
//   notify() {
//     notifyListeners();
//   }

//   Stream<List<UserModel>> getAllUsers() {
//     return firebaseFirestore.collection('users').snapshots().map(
//       (snapshot) {
//         List<UserModel> users = snapshot.docs
//             .map((doc) => UserModel.fromJson(doc.data()))
//             .where((user) => user.isAdmin != true) // Exclude admins
//             .toList();

//         return users;
//       },
//     );
//   }

//   Stream<List<UserModel>> getUserByEmail(String email) {
//     return firebaseFirestore
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .snapshots()
//         .map((snapshot) {
//       if (snapshot.docs.isNotEmpty) {
//         // Return the first UserModel in a List
//         return [UserModel.fromJson(snapshot.docs.first.data())];
//       }
//       return []; // Return an empty list if no user found
//     });
//   }

//   Future<void> updateUser(UserModel user) async {
//     try {
//       var userQuery = firebaseFirestore
//           .collection('users')
//           .where('email', isEqualTo: user.email);

//       var querySnapshot = await userQuery.get();

//       if (querySnapshot.docs.isNotEmpty) {
//         var userDoc =
//             querySnapshot.docs.first; // Get the first matched document
//         var userDocRef = userDoc.reference; // Reference to the document

//         await userDocRef.update({
//           'gheeDailyTasks': user.gheeDailyTasks,
//         });

//         log('User updated successfully');
//       } else {
//         log('User not found');
//       }
//     } catch (e) {
//       log('Error updating user: $e');
//     }
//   }

//   Future<void> updateUserEnterableTask(
//       String email, String task, int newValue) async {
//     try {
//       var userQuery = firebaseFirestore
//           .collection('users')
//           .where('email', isEqualTo: email);

//       var querySnapshot = await userQuery.get();

//       if (querySnapshot.docs.isNotEmpty) {
//         var userDoc =
//             querySnapshot.docs.first; // Get the first matched document
//         var userDocRef = userDoc.reference; // Reference to the document

//         await userDocRef.update({
//           task: newValue,
//         });

//         log('User updated successfully');
//       } else {
//         log('User not found');
//       }
//     } catch (e) {
//       log('Error updating user: $e');
//     }
//   }

//   Future<void> clearAllGheeDailyTasks(String email) async {
//     try {
//       final userSnapshot = await firebaseFirestore
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();

//       if (userSnapshot.docs.isNotEmpty) {
//         final userDoc = userSnapshot.docs.first;

//         // Clear the milkDailyTasks list
//         await userDoc.reference.update({
//           'gheeDailyTasks': [], // Set the list to an empty array
//         });

//         log('All Ghee daily tasks cleared successfully.');
//         notifyListeners(); // Notify listeners if the UI needs to be updated
//       } else {
//         log('User not found with email: $email');
//       }
//     } catch (e) {
//       log('Error clearing milk daily tasks: $e');
//     }
//   }

//   Future<void> saveAllUsersGheeData() async {
//     try {
//       // Fetch all users from the 'users' collection
//       final usersSnapshot = await firebaseFirestore.collection('users').get();

//       // Iterate over each user document
//       for (var userDoc in usersSnapshot.docs) {
//         final email = userDoc['email'];
//         final userName = userDoc['userName'];
//         final milkDailyAmount = userDoc['gheeDailyAmount'];
//         final milkDailyQuantity = userDoc['gheeDailyQuantity'];
//         final milkDailyTasks = userDoc['gheeDailyTasks'];

//         if (milkDailyTasks != null && milkDailyTasks.isNotEmpty) {
//           // Create a reference for the new document in 'all_time_data' collection
//           final allTimeDataRef =
//               firebaseFirestore.collection('all_time_ghee_data').doc();

//           // Prepare the data to be saved
//           final milkData = {
//             'userName': userName,
//             'email': email,
//             'gheeDailyAmount': milkDailyAmount,
//             'gheeDailyQuantity': milkDailyQuantity,
//             'gheeDailyTasks': milkDailyTasks,
//             'timestamp': FieldValue
//                 .serverTimestamp(), // Add timestamp for when this data was saved
//           };

//           // Save the milk data to the 'all_time_data' collection
//           await allTimeDataRef.set(milkData);

//           log('ghee data for user $email saved to all_time_data successfully.');
//         } else {
//           log('No milk data found for user $email.');
//         }
//       }
//     } catch (e) {
//       log('Error saving all users\' milk data: $e');
//     }
//   }

//   Future<void> deleteAllTimeGheeData(String documentId) async {
//     try {
//       // Reference to the document to be deleted in the 'all_time_data' collection
//       var documentRef = FirebaseFirestore.instance
//           .collection('all_time_ghee_data')
//           .doc(documentId);

//       // Delete the document
//       await documentRef.delete();

//       log('All-time Ghee data with ID $documentId deleted successfully.');
//     } catch (e) {
//       log('Error deleting all-time milk data: $e');
//     }
//   }

//   Future<void> clearGheeTasksForAllUsers(BuildContext context) async {
//     try {
//       bool confirm = await showDialog<bool>(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text("Confirm Task Reset"),
//               content: const Text(
//                 "Are you sure you want to clear the 'Ghee Daily Tasks' for all users? This action cannot be undone. Make Sure To Save the Data",
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   child: const Text("Clear Tasks"),
//                 ),
//               ],
//             ),
//           ) ??
//           false;

//       if (confirm) {
//         QuerySnapshot snapshot =
//             await firebaseFirestore.collection('users').get();
//         for (var doc in snapshot.docs) {
//           await doc.reference.update({
//             'gheeDailyTasks': [],
//             'gheeDailyAmount': 0,
//             'gheeDailyQuantity': 0,
//           });
//         }
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: const Text("All Ghee daily tasks have been cleared.")));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';

class GheeProductController extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Set<String> selectedItems = {};
  notify() {
    notifyListeners();
  }

  Stream<List<UserModel>> getAllUsers() {
    return firebaseFirestore.collection('users').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .where((user) => user.isAdmin != true) // Exclude admins
            .toList();
      },
    );
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
        var userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          'gheeDailyTasks': user.gheeDailyTasks,
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
        var userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          task: newValue,
        });

        log('User updated successfully');
      } else {
        log('User not found');
      }
    } catch (e) {
      log('Error updating user: $e');
    }
  }

  Future<void> clearAllGheeDailyTasks(String email) async {
    try {
      final userSnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDocRef = userSnapshot.docs.first.reference;

        await userDocRef.update({
          'gheeDailyTasks': [],
          'gheeDailyAmount': 0,
          'gheeDailyQuantity': 0,
        });

        log('All Ghee daily tasks cleared successfully.');
        notifyListeners();
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error clearing Ghee daily tasks: $e');
    }
  }

  Future<void> saveAllUsersGheeData() async {
    try {
      final usersSnapshot = await firebaseFirestore.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        final email =
            userDoc.data().containsKey('email') ? userDoc['email'] : '';
        final userName =
            userDoc.data().containsKey('userName') ? userDoc['userName'] : '';
        final gheeDailyAmount = userDoc.data().containsKey('gheeDailyAmount')
            ? userDoc['gheeDailyAmount']
            : 0;
        final gheeDailyQuantity =
            userDoc.data().containsKey('gheeDailyQuantity')
                ? userDoc['gheeDailyQuantity']
                : 0;
        final gheeDailyTasks = userDoc.data().containsKey('gheeDailyTasks')
            ? userDoc['gheeDailyTasks']
            : [];
        final previousGheeBalance =
            userDoc.data().containsKey('previousGheeBalance')
                ? userDoc['previousGheeBalance']
                : 0;

        if (gheeDailyTasks.isNotEmpty) {
          final allTimeDataRef =
              firebaseFirestore.collection('all_time_ghee_data').doc();

          final gheeData = {
            'userName': userName,
            'email': email,
            'gheeDailyAmount': gheeDailyAmount,
            'gheeDailyQuantity': gheeDailyQuantity,
            'gheeDailyTasks': gheeDailyTasks,
            'previousGheeBalance': previousGheeBalance,
            'timestamp': FieldValue.serverTimestamp(),
          };

          await allTimeDataRef.set(gheeData);

          log('Ghee data for user $email saved to all_time_ghee_data successfully.');
        } else {
          log('No Ghee data found for user $email.');
        }
      }
    } catch (e) {
      log('Error saving all users\' Ghee data: $e');
    }
  }

  Future<void> deleteAllTimeGheeData(String documentId) async {
    try {
      var documentRef =
          firebaseFirestore.collection('all_time_ghee_data').doc(documentId);

      await documentRef.delete();

      log('All-time Ghee data with ID $documentId deleted successfully.');
    } catch (e) {
      log('Error deleting all-time Ghee data: $e');
    }
  }

  Future<void> clearGheeTasksForAllUsers(BuildContext context) async {
    try {
      bool confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirm Task Reset"),
              content: const Text(
                "Are you sure you want to clear the 'Ghee Daily Tasks' for all users? This action cannot be undone. Make sure to save the data first.",
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
        final snapshot = await firebaseFirestore.collection('users').get();

        for (var doc in snapshot.docs) {
          await doc.reference.update({
            'gheeDailyTasks': [],
            'gheeDailyAmount': 0,
            'gheeDailyQuantity': 0,
            'previousGheeBalance': 0,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("All Ghee daily tasks have been cleared.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
