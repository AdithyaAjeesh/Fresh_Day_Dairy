import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/butter_product_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllTimeButterDataScreen extends StatelessWidget {
  final String userEmail;

  const AllTimeButterDataScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ButterProductController>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Butter Data Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('all_time_butter_data')
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
            var butterDailyTasks =
                List<int>.from(data['butterDailyTasks'] ?? []);
            var butterDailyQuantity = data['butterDailyQuantity'] ?? 0;
            var butterDailyAmount = data['butterDailyAmount'] ?? 0;
            var previousBalance = data['previousButterBalance'] ?? 0;
            var timestamp = data['timestamp']?.toDate() ?? DateTime.now();
            butterDailyTasks.sort();

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
                              prov.deleteAllTimeButterData(docId);
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
                      // Butter daily data
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
                        'Butter Daily Quantity: $butterDailyQuantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Butter Daily Amount: ₹$butterDailyAmount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Butter Daily Tasks:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Daily tasks list
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: butterDailyTasks
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
