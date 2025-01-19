import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/curd_product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/curd/all_time_curd_data_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/user_list_screen.dart';
import 'package:provider/provider.dart';

class CurdDetailsScreen extends StatelessWidget {
  final bool? isAdmin;
  final String email;

  const CurdDetailsScreen({
    super.key,
    required this.email,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final pro = Provider.of<CurdProductController>(context);

    Future<void> showUpdateDialog(BuildContext context, String title,
        double initialValue, Function(double) onUpdate) {
      final TextEditingController controller =
          TextEditingController(text: initialValue.toString());

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter new value',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  double? newValue = double.tryParse(controller.text);
                  if (newValue != null) {
                    onUpdate(newValue);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: const Text("Please enter a valid number")));
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     pro.clearMilkTasksForAllUsers(context);
      //   },
      //   child: const Icon(Icons.delete),
      // ),
      appBar: AppBar(
        title: Text(
          'Curd Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: theme.tertiary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.tertiary,
          ),
        ),
        actions: [
          if (isAdmin!)
            Row(
              children: [
                // Add the Dropdown Button in AppBar actions
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Handle the selected value
                    if (value == 'save') {
                      pro.saveAllUsersCurdData();
                    } else if (value == 'clear') {
                      pro.clearCurdTasksForAllUsers(context);
                    } else if (value == 'data') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserListScreen(
                            collectionName: 'all_time_curd_data',
                            detailScreenBuilder: (email) {
                              return AllTimeCurdDataScreen(userEmail: email);
                            },
                          ),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'save',
                        child: Text('Save All Curd Data'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'clear',
                        child: Text('Clear Curd Tasks'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'data',
                        child: Text('Show All Data'),
                      ),
                    ];
                  },
                ),
              ],
            ),
        ],
        centerTitle: false,
        backgroundColor: theme.surface,
      ),
      backgroundColor: theme.secondary,
      body:
          Consumer<CurdProductController>(builder: (context, provider, child) {
        return StreamBuilder<List<UserModel>>(
          stream: isAdmin!
              ? provider.getAllUsers() // Stream of all users for admin
              : provider.getUserByEmail(
                  email), // Stream of a single user for non-admin
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No users found'));
            }

            List<UserModel> users;
            if (isAdmin!) {
              users = snapshot.data!; // List of users for admin
            } else {
              users = [snapshot.data!.first]; // Single user data for non-admin
            }

            double totalAmount = 0.0;
            for (var user in users) {
              totalAmount +=
                  user.curdDailyAmount ?? 0.0; // Add the user's milkDailyAmount
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      columnWidths: {
                        0: const FixedColumnWidth(150.0), // Name column
                        1: const FixedColumnWidth(
                            150.0), // Previous Balance column
                        2: const FixedColumnWidth(100.0), // Quantity column
                        for (int i = 3; i <= 33; i++)
                          i: const FixedColumnWidth(50.0), // Dates
                        34: const FixedColumnWidth(100.0), // Amount column
                      },
                      children: [
                        // Header Row
                        TableRow(
                          decoration: BoxDecoration(color: theme.surface),
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Previous Balance',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // Add dynamic date columns (1-31)
                            for (int i = 1; i <= 31; i++)
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$i',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data Rows
                        for (var user in users)
                          TableRow(
                            children: [
                              // Name Column
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    user.userName ?? 'Unknown User',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              // Previous Balance Column
                              TableCell(
                                child: InkWell(
                                  onTap: () {
                                    log(user.email!);

                                    if (isAdmin!) {
                                      showUpdateDialog(
                                        context,
                                        'Previous Balance',
                                        user.previousCurdBalance!.toDouble(),
                                        (p0) {
                                          pro.updateUserEnterableTask(
                                              user.email!,
                                              'previousCurdBalance',
                                              p0.toInt());
                                        },
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.previousCurdBalance?.toString() ??
                                          '0.0',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              // Quantity Column
                              TableCell(
                                child: InkWell(
                                  onTap: () {
                                    log(user.email!);

                                    if (isAdmin!) {
                                      showUpdateDialog(
                                        context,
                                        'Daily Quantity',
                                        user.curdDailyQuantity!.toDouble(),
                                        (p0) {
                                          pro.updateUserEnterableTask(
                                              user.email!,
                                              'curdDailyQuantity',
                                              p0.toInt());
                                        },
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.curdDailyQuantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              // Add dynamic checkboxes for dates (1-31)
                              for (int i = 1; i <= 31; i++)
                                TableCell(
                                  child: Center(
                                    child: Checkbox(
                                      value: user.isCurdTaskCompletedForDate(i),
                                      onChanged: (value) {
                                        if (isAdmin!) {
                                          if (value == true) {
                                            user.curdDailyTasks.add(i);
                                          } else {
                                            user.curdDailyTasks.remove(i);
                                          }
                                          provider.updateUser(user);
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              // Amount Column
                              TableCell(
                                child: InkWell(
                                  onTap: () {
                                    log(user.email!);

                                    if (isAdmin!) {
                                      showUpdateDialog(
                                        context,
                                        'Daily Amount',
                                        user.curdDailyAmount!.toDouble(),
                                        (p0) {
                                          pro.updateUserEnterableTask(
                                              user.email!,
                                              'curdDailyAmount',
                                              p0.toInt());
                                        },
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.curdDailyAmount.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  color: theme.surface,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        totalAmount
                            .toString(), // Total amount calculation logic goes here
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
