// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
// import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
// import 'package:fresh_day_dairy_project/home/widgets/product_card.dart';
// import 'package:fresh_day_dairy_project/notification/notification_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/butter/butter_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/butter/butter_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/curd/curd_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/curd/curd_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/ghee/ghee_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/ghee/ghee_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/milk/milk_details_screen.dart';
// import 'package:fresh_day_dairy_project/products_screen/milk/milk_screen.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Home',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//             color: theme.tertiary,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 // ignore: prefer_const_constructors
//                 builder: (context) => NotificationScreen(),
//               ));
//             },
//             icon: Icon(
//               Icons.notification_add_outlined,
//               color: theme.tertiary,
//               size: 25,
//             ),
//           ),
//         ],
//         backgroundColor: theme.surface,
//       ),
//       backgroundColor: theme.secondary,
//       body: Center(
//         child:
//             Consumer<AuthController>(builder: (context, authProvider, child) {
//           return ListView(
//             children: [
//               ProductCard(
//                 callback: () async {
//                   UserModel? user = await authProvider.getCurrentUser();
//                   if (user!.isAdmin!) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const MilkScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => MilkDetailsScreen(
//                           email: user.email!,
//                           isAdmin: user.isAdmin,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 image: 'assets/milk.jpg',
//                 title: "Milk",
//                 subTitle: 'The Best Milk available in the market',
//               ),
//               ProductCard(
//                 callback: () async {
//                   UserModel? user = await authProvider.getCurrentUser();
//                   if (user!.isAdmin!) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const ButterMilkScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ButterMilkDetailsScreen(
//                           email: user.email!,
//                           isAdmin: user.isAdmin,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 image: 'assets/butter_milk.jpg',
//                 title: "Butter Milk",
//                 subTitle: 'The Best Milk available in the market',
//               ),
//               ProductCard(
//                 callback: () async {
//                   UserModel? user = await authProvider.getCurrentUser();
//                   if (user!.isAdmin!) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const GheeScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => GheeDetailsScreen(
//                           email: user.email!,
//                           isAdmin: user.isAdmin,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 image: 'assets/ghee.jpg',
//                 title: "Ghee",
//                 subTitle: 'The Best Milk available in the market',
//               ),
//               ProductCard(
//                 callback: () async {
//                   UserModel? user = await authProvider.getCurrentUser();
//                   if (user!.isAdmin!) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const CurdScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => CurdDetailsScreen(
//                           email: user.email!,
//                           isAdmin: user.isAdmin,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 image: 'assets/curd.jpg',
//                 title: "Curd",
//                 subTitle: 'The Best Milk available in the market',
//               ),
//               ProductCard(
//                 callback: () async {
//                   UserModel? user = await authProvider.getCurrentUser();
//                   if (user!.isAdmin!) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const ButterScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ButterDetailsScreen(
//                           email: user.email!,
//                           isAdmin: user.isAdmin,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 image: 'assets/butter.jpg',
//                 title: "Butter",
//                 subTitle: 'The Best Milk available in the market',
//               )
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/home/widgets/product_card.dart';
import 'package:fresh_day_dairy_project/notification/notification_screen.dart';
import 'package:provider/provider.dart';

import 'package:fresh_day_dairy_project/products_screen/butter/butter_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/butter/butter_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/curd/curd_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/curd/curd_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/ghee/ghee_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/ghee/ghee_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/milk/milk_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/milk/milk_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: theme.tertiary,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.notification_add_outlined,
              color: theme.tertiary,
              size: 25,
            ),
          ),
        ],
        backgroundColor: theme.surface,
      ),
      backgroundColor: theme.secondary,
      body: Center(
        child:
            Consumer<AuthController>(builder: (context, authProvider, child) {
          return FutureBuilder<UserModel?>(
            future: authProvider.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return const Text("User not found.");
              }

              final user = snapshot.data!;
              final bool isAdmin = user.isAdmin ?? false;

              final productList = [
                {
                  "title": "Milk",
                  "subTitle": "The Best Milk available in the market",
                  "image": "assets/milk.jpg",
                  "adminScreen": const MilkScreen(),
                  "userScreen":
                      MilkDetailsScreen(email: user.email!, isAdmin: isAdmin),
                },
                {
                  "title": "Butter Milk",
                  "subTitle": "The Best Milk available in the market",
                  "image": "assets/butter_milk.jpg",
                  "adminScreen": const ButterMilkScreen(),
                  "userScreen": ButterMilkDetailsScreen(
                      email: user.email!, isAdmin: isAdmin),
                },
                {
                  "title": "Ghee",
                  "subTitle": "The Best Milk available in the market",
                  "image": "assets/ghee.jpg",
                  "adminScreen": const GheeScreen(),
                  "userScreen":
                      GheeDetailsScreen(email: user.email!, isAdmin: isAdmin),
                },
                {
                  "title": "Curd",
                  "subTitle": "The Best Milk available in the market",
                  "image": "assets/curd.jpg",
                  "adminScreen": const CurdScreen(),
                  "userScreen":
                      CurdDetailsScreen(email: user.email!, isAdmin: isAdmin),
                },
                {
                  "title": "Butter",
                  "subTitle": "The Best Milk available in the market",
                  "image": "assets/butter.jpg",
                  "adminScreen": const ButterScreen(),
                  "userScreen":
                      ButterDetailsScreen(email: user.email!, isAdmin: isAdmin),
                },
              ];

              return ListView(
                children: productList.map((product) {
                  return ProductCard(
                    title: product["title"] as String,
                    subTitle: product["subTitle"] as String,
                    image: product["image"] as String,
                    callback: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => isAdmin
                              ? product["adminScreen"] as Widget
                              : product["userScreen"] as Widget,
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
          );
        }),
      ),
    );
  }
}
