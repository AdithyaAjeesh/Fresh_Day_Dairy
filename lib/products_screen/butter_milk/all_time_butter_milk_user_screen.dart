import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_day_dairy_project/products_screen/butter_milk/all_time_butter_milk_data_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/milk/All_time_milk_data_screen.dart';
import 'package:provider/provider.dart';

class AllTimeButterMilkUserScreen extends StatelessWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  AllTimeButterMilkUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProductController>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection('all_time_butter_milk_data')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          final allTimeData = snapshot.data!.docs;
          final uniqueUsers = <String, Map<String, dynamic>>{};
          for (var doc in allTimeData) {
            var data = doc.data() as Map<String, dynamic>;
            var email = data['email'] ?? '';
            if (!uniqueUsers.containsKey(email)) {
              uniqueUsers[email] = data;
            }
          }

          final uniqueUserList = uniqueUsers.values.toList();

          return ListView.builder(
            itemCount: uniqueUserList.length,
            itemBuilder: (context, index) {
              var data = uniqueUserList[index];
              var userName = data['userName'] ?? 'No User Name';
              var email = data['email'] ?? 'No email';

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: theme.secondary,
                child: ListTile(
                  title: Row(
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: theme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to the details screen using the user's email
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AllTimeButterMilkDataScreen(userEmail: email),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
