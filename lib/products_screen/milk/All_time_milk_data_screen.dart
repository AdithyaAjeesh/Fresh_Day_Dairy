// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fresh_day_dairy_project/products_screen/controller/milk_product_controller.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class AllTimeMilkDataScreen extends StatelessWidget {
//   final String userEmail;

//   const AllTimeMilkDataScreen({super.key, required this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     final prov = Provider.of<MilkProductController>(context);
//     final theme = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Milk Data Details'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('all_time_data')
//             .where('email', isEqualTo: userEmail) // Filter by the user email
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//                 child: Text('No data available for this user.'));
//           }

//           // List to store the data for all the documents
//           List<Widget> dataWidgets = [];

//           // Iterate over each document for the user
//           for (var doc in snapshot.data!.docs) {
//             var data =
//                 doc.data() as Map<String, dynamic>; // Extract the document data
//             var userName = data['userName'] ?? 'No User Name';
//             var docId = doc.id;
//             var email = data['email'] ?? 'No email';
//             var milkDailyTasks = List<int>.from(data['milkDailyTasks'] ?? []);
//             var milkDailyQuantity = data['milkDailyQuantity'] ?? 0;
//             var milkDailyAmount = data['milkDailyAmount'] ?? 0;
//             var timestamp = data['timestamp']?.toDate() ?? DateTime.now();
//             milkDailyTasks.sort();
//             // Create a widget for each document's data
//             dataWidgets.add(Card(
//               margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               color: theme.secondary,
//               child: ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: theme.tertiary,
//                           ),
//                         ),
//                         Text(
//                           email,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: theme.tertiary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         prov.deleteAllTimeMilkData(docId);
//                       },
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),
//                     // Text('Timestamp: ${timestamp.toLocal()}'),
//                     Text(
//                       'Date: ${DateFormat('yyyy-MM-dd').format(timestamp.toLocal())}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: theme.tertiary,
//                       ),
//                     ),

//                     const SizedBox(height: 10),
//                     Text(
//                       'Milk Daily Quantity: $milkDailyQuantity',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: theme.tertiary,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Milk Daily Amount: $milkDailyAmount',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: theme.tertiary,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Milk Daily Tasks:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: theme.tertiary,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ...milkDailyTasks.map(
//                       (task) => Padding(
//                         padding: const EdgeInsets.all(4),
//                         child: Text(
//                           'Day - $task',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: theme.tertiary,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ));
//           }

//           return ListView(
//             children: dataWidgets, // Display all the widgets for each document
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/milk_product_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllTimeMilkDataScreen extends StatelessWidget {
  final String userEmail;

  const AllTimeMilkDataScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MilkProductController>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Data Details'),
        backgroundColor: theme.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('all_time_data')
            .where('email', isEqualTo: userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No data available for this user.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          List<Widget> dataWidgets = [];

          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            var userName = data['userName'] ?? 'No User Name';
            var docId = doc.id;
            var email = data['email'] ?? 'No email';
            var milkDailyTasks = List<int>.from(data['milkDailyTasks'] ?? []);
            var milkDailyQuantity = data['milkDailyQuantity'] ?? 0;
            var milkDailyAmount = data['milkDailyAmount'] ?? 0;
            var previousBalance = data['previousMilkBalance'] ?? 0;
            var timestamp = data['timestamp']?.toDate() ?? DateTime.now();
            milkDailyTasks.sort();

            dataWidgets.add(
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: theme.secondary,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with user name and email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: theme.tertiary,
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              prov.deleteAllTimeMilkData(docId);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: theme.onSecondary, thickness: 1),
                      const SizedBox(height: 10),
                      // Date information
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(timestamp.toLocal())}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Milk data
                      Text(
                        'Previous Balance: ₹$previousBalance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Milk Daily Quantity: $milkDailyQuantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Milk Daily Amount: ₹$milkDailyAmount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Milk Daily Tasks:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Task list
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: milkDailyTasks
                            .map(
                              (task) => Chip(
                                label: Text(
                                  'Day $task',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: theme.onSecondary,
                                  ),
                                ),
                                backgroundColor: theme.primary,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView(
            children: dataWidgets,
          );
        },
      ),
    );
  }
}
