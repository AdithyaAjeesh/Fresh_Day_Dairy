// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';

// class ButterMilkProductController extends ChangeNotifier {
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
//           'butterMilkDailyTasks': user.butterMilkDailyTasks,
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

//   Future<void> clearAllButterMilkDailyTasks(String email) async {
//     try {
//       final userSnapshot = await firebaseFirestore
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();

//       if (userSnapshot.docs.isNotEmpty) {
//         final userDoc = userSnapshot.docs.first;

//         // Clear the milkDailyTasks list
//         await userDoc.reference.update({
//           'butterMilkDailyTasks': [], // Set the list to an empty array
//         });

//         log('All Butter milk daily tasks cleared successfully.');
//         notifyListeners(); // Notify listeners if the UI needs to be updated
//       } else {
//         log('User not found with email: $email');
//       }
//     } catch (e) {
//       log('Error clearing milk daily tasks: $e');
//     }
//   }

//   Future<void> saveAllUsersButterMilkData() async {
//     try {
//       // Fetch all users from the 'users' collection
//       final usersSnapshot = await firebaseFirestore.collection('users').get();

//       // Iterate over each user document
//       for (var userDoc in usersSnapshot.docs) {
//         final email = userDoc['email'];
//         final userName = userDoc['userName'];
//         final milkDailyAmount = userDoc['butterMilkDailyAmount'];
//         final milkDailyQuantity = userDoc['butterMilkDailyQuantity'];
//         final milkDailyTasks = userDoc['butterMilkDailyTasks'];

//         if (milkDailyTasks != null && milkDailyTasks.isNotEmpty) {
//           // Create a reference for the new document in 'all_time_data' collection
//           final allTimeDataRef =
//               firebaseFirestore.collection('all_time_butter_milk_data').doc();

//           // Prepare the data to be saved
//           final milkData = {
//             'userName': userName,
//             'email': email,
//             'butterMilkDailyAmount': milkDailyAmount,
//             'butterMilkDailyQuantity': milkDailyQuantity,
//             'butterMilkDailyTasks': milkDailyTasks,
//             'timestamp': FieldValue
//                 .serverTimestamp(), // Add timestamp for when this data was saved
//           };

//           // Save the milk data to the 'all_time_data' collection
//           await allTimeDataRef.set(milkData);

//           log('Milk data for user $email saved to all_time_data successfully.');
//         } else {
//           log('No milk data found for user $email.');
//         }
//       }
//     } catch (e) {
//       log('Error saving all users\' milk data: $e');
//     }
//   }

//   Future<void> deleteAllTimeButterMilkData(String documentId) async {
//     try {
//       // Reference to the document to be deleted in the 'all_time_data' collection
//       var documentRef = FirebaseFirestore.instance
//           .collection('all_time_butter_milk_data')
//           .doc(documentId);

//       // Delete the document
//       await documentRef.delete();

//       log('All-time Butter milk data with ID $documentId deleted successfully.');
//     } catch (e) {
//       log('Error deleting all-time milk data: $e');
//     }
//   }

//   Future<void> clearButterMilkTasksForAllUsers(BuildContext context) async {
//     try {
//       bool confirm = await showDialog<bool>(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text("Confirm Task Reset"),
//               content: const Text(
//                 "Are you sure you want to clear the 'Butter Milk Daily Tasks' for all users? This action cannot be undone. Make Sure To Save the Data",
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
//             'butterMilkDailyTasks': [],
//             'butterMilkDailyAmount': 0,
//             'butterMilkDailyQuantity': 0,
//           });
//         }
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: const Text("All milk daily tasks have been cleared.")));
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

class ButterMilkProductController extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static const String usersCollection = 'users';
  static const String allTimeDataCollection = 'all_time_butter_milk_data';

  Set<String> selectedItems = {};

  void notify() {
    notifyListeners();
  }

  Stream<List<UserModel>> getAllUsers() {
    return firebaseFirestore.collection(usersCollection).snapshots().map(
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
        .collection(usersCollection)
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
      final userQuery = firebaseFirestore
          .collection(usersCollection)
          .where('email', isEqualTo: user.email);

      final querySnapshot = await userQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          'butterMilkDailyTasks': user.butterMilkDailyTasks,
          'butterMilkDailyAmount': user.butterMilkDailyAmount,
          'previousButterMilkBalance': user.previousButterMilkBalance,
        });

        log('User updated successfully.');
      } else {
        log('User not found.');
      }
    } catch (e) {
      log('Error updating user: $e');
    }
  }

  Future<void> updateUserEnterableTask(
      String email, String task, int newValue) async {
    try {
      final userQuery = firebaseFirestore
          .collection(usersCollection)
          .where('email', isEqualTo: email);

      final querySnapshot = await userQuery.get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          task: newValue,
        });

        log('User task updated successfully.');
      } else {
        log('User not found.');
      }
    } catch (e) {
      log('Error updating user task: $e');
    }
  }

  Future<void> clearAllButterMilkDailyTasks(String email) async {
    try {
      final userSnapshot = await firebaseFirestore
          .collection(usersCollection)
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDocRef = userSnapshot.docs.first.reference;

        await userDocRef.update({
          'butterMilkDailyTasks': [],
          'butterMilkDailyAmount': 0,
          'previousButterMilkBalance': 0,
        });

        log('All Butter Milk daily tasks cleared successfully.');
        notifyListeners();
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error clearing Butter Milk daily tasks: $e');
    }
  }

  Future<void> saveAllUsersButterMilkData() async {
    try {
      // Fetch all users from the 'users' collection
      final usersSnapshot =
          await firebaseFirestore.collection(usersCollection).get();

      // Iterate over each user document
      for (var userDoc in usersSnapshot.docs) {
        final data = userDoc.data();

        final email = data['email'] ?? '';
        final userName = data['userName'] ?? 'Unknown User';
        final butterMilkDailyAmount = data['butterMilkDailyAmount'] ?? 0;
        final butterMilkDailyQuantity = data['butterMilkDailyQuantity'] ?? 0;
        final butterMilkDailyTasks =
            List<int>.from(data['butterMilkDailyTasks'] ?? []);
        final previousButterMilkBalance =
            data.containsKey('previousButterMilkBalance')
                ? data['previousButterMilkBalance']
                : 0; // Handle missing field

        if (butterMilkDailyTasks.isNotEmpty) {
          // Calculate the total amount
          final totalAmount = butterMilkDailyAmount + previousButterMilkBalance;

          // Create a reference for the new document in the 'all_time_butter_milk_data' collection
          final allTimeDataRef =
              firebaseFirestore.collection(allTimeDataCollection).doc();

          // Prepare the data to be saved
          final butterMilkData = {
            'userName': userName,
            'email': email,
            'butterMilkDailyAmount': butterMilkDailyAmount,
            'butterMilkDailyQuantity': butterMilkDailyQuantity,
            'butterMilkDailyTasks': butterMilkDailyTasks,
            'previousButterMilkBalance': previousButterMilkBalance,
            'totalAmount': totalAmount,
            'timestamp': FieldValue.serverTimestamp(),
          };

          // Save the data to the 'all_time_butter_milk_data' collection
          await allTimeDataRef.set(butterMilkData);
          log('Butter Milk data for $email saved successfully.');
        } else {
          log('No Butter Milk tasks found for $email.');
        }
      }
    } catch (e) {
      log('Error saving Butter Milk data: $e');
    }
  }

  Future<void> deleteAllTimeButterMilkData(String documentId) async {
    try {
      final documentRef =
          firebaseFirestore.collection(allTimeDataCollection).doc(documentId);

      await documentRef.delete();

      log('All-time Butter Milk data with ID $documentId deleted successfully.');
    } catch (e) {
      log('Error deleting all-time Butter Milk data: $e');
    }
  }

  Future<void> clearButterMilkTasksForAllUsers(BuildContext context) async {
    try {
      final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirm Task Reset"),
              content: const Text(
                "Are you sure you want to clear the 'Butter Milk Daily Tasks' for all users? This action cannot be undone. Make sure to save the data first.",
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
        final usersSnapshot =
            await firebaseFirestore.collection(usersCollection).get();

        for (var userDoc in usersSnapshot.docs) {
          await userDoc.reference.update({
            'butterMilkDailyTasks': [],
            'butterMilkDailyAmount': 0,
            'butterMilkDailyQuantity': 0,
            'previousButterMilkBalance': 0,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("All Butter Milk daily tasks have been cleared."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
