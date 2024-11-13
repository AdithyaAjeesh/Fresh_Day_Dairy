// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:fresh_day_dairy_project/products_screen/add_product_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/controller/product_controller.dart';
// import 'package:provider/provider.dart';

// class ButterDetailsScreen extends StatelessWidget {
//   final bool? isAdmin;
//   final String email;
//   const ButterDetailsScreen({
//     super.key,
//     required this.email,
//     required this.isAdmin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(
//       //     'Butter Details',
//       //     style: TextStyle(
//       //       fontWeight: FontWeight.bold,
//       //       fontSize: 25,
//       //       color: theme.tertiary,
//       //     ),
//       //   ),
//       //   leading: IconButton(
//       //     onPressed: () {
//       //       Navigator.of(context).pop(context);
//       //     },
//       //     icon: Icon(
//       //       Icons.arrow_back_ios,
//       //       color: theme.tertiary,
//       //     ),
//       //   ),
//       //   actions: [
//       //     isAdmin!
//       //         ? IconButton(
//       //             onPressed: () {
//       //               Navigator.of(context).push(MaterialPageRoute(
//       //                 builder: (context) => AddProductDetailsScreen(
//       //                   email: email,
//       //                   taskCatagory: 'butterDailyTasks',
//       //                 ),
//       //               ));
//       //             },
//       //             icon: Icon(
//       //               Icons.add,
//       //               color: theme.tertiary,
//       //             ),
//       //           )
//       //         : const SizedBox(),
//       //   ],
//       //   centerTitle: false,
//       //   backgroundColor: theme.surface,
//       // ),
//       // backgroundColor: theme.secondary,
//       // body: Consumer<ProductController>(builder: (context, provider, child) {
//       //   return StreamBuilder(
//       //     stream: provider.getUserByEmail(email.toString()),
//       //     builder: (context, snapshot) {
//       //       log(email.toString());
//       //       if (snapshot.connectionState == ConnectionState.waiting) {
//       //         return const Center(child: CircularProgressIndicator());
//       //       } else if (snapshot.hasError) {
//       //         return Center(
//       //           child: Text('Error: ${snapshot.error}'),
//       //         );
//       //       } else if (snapshot.hasError) {
//       //         return Center(child: Text('Error ${snapshot.error}'));
//       //       }

//       //       final tasks = snapshot.data!.butterDailyTasks!;
//       //       double totalAmount = tasks.fold(0, (sum, task) {
//       //         return sum + (double.tryParse(task.amount ?? '0') ?? 0);
//       //       });

//       //       return Column(
//       //         children: [
//       //           const SizedBox(height: 20),
//       //           Container(
//       //             height: 50,
//       //             width: MediaQuery.of(context).size.width - 20,
//       //             decoration: BoxDecoration(
//       //               borderRadius: BorderRadius.circular(10),
//       //               color: theme.primary,
//       //             ),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //               children: [
//       //                 Text(
//       //                   'Date',
//       //                   style: TextStyle(
//       //                     color: theme.surface,
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 18,
//       //                   ),
//       //                 ),
//       //                 const SizedBox(width: 5),
//       //                 Text(
//       //                   'Quantity',
//       //                   style: TextStyle(
//       //                     color: theme.surface,
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 18,
//       //                   ),
//       //                 ),
//       //                 Text(
//       //                   'Amount',
//       //                   style: TextStyle(
//       //                     color: theme.surface,
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 18,
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //           Expanded(
//       //             child: ListView.builder(
//       //               itemCount: tasks.length,
//       //               itemBuilder: (context, index) {
//       //                 final task = tasks[index];
//       //                 return Container(
//       //                   height: 50,
//       //                   margin: const EdgeInsets.all(10),
//       //                   decoration: BoxDecoration(
//       //                     borderRadius: BorderRadius.circular(10),
//       //                     color: theme.surface,
//       //                   ),
//       //                   child: Row(
//       //                     children: [
//       //                       const SizedBox(width: 30),
//       //                       Expanded(
//       //                         child: Text(
//       //                           task.date.toString(),
//       //                           style: TextStyle(
//       //                             color: theme.tertiary,
//       //                             fontWeight: FontWeight.bold,
//       //                             fontSize: 16,
//       //                           ),
//       //                         ),
//       //                       ),
//       //                       const SizedBox(width: 40),
//       //                       Expanded(
//       //                         child: Text(
//       //                           task.quantity.toString(),
//       //                           style: TextStyle(
//       //                             color: theme.tertiary,
//       //                             fontWeight: FontWeight.bold,
//       //                             fontSize: 16,
//       //                           ),
//       //                         ),
//       //                       ),
//       //                       Expanded(
//       //                         child: Text(
//       //                           task.amount.toString(),
//       //                           style: TextStyle(
//       //                             color: theme.tertiary,
//       //                             fontWeight: FontWeight.bold,
//       //                             fontSize: 16,
//       //                           ),
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 );
//       //               },
//       //             ),
//       //           ),
//       //           Container(
//       //             height: 80,
//       //             color: theme.surface,
//       //             width: MediaQuery.of(context).size.width,
//       //             padding: const EdgeInsets.all(20),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 const Text(
//       //                   'Total Amount: ',
//       //                   style: TextStyle(
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 18,
//       //                   ),
//       //                 ),
//       //                 Text(
//       //                   totalAmount.toString(),
//       //                   style: const TextStyle(
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 18,
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   );
//       // }),
//     );
//   }
// }
