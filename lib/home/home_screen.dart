// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/home/widgets/product_card.dart';
import 'package:fresh_day_dairy_project/notification/notification_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/butter/butter_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/curd/curd_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/milk/milk_details_screen.dart';
import 'package:provider/provider.dart';

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
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                // ignore: prefer_const_constructors
                builder: (context) => NotificationScreen(),
              ));
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
          return ListView(
            children: [
              ProductCard(
                callback: () async {
                  UserModel? user = await authProvider.getCurrentUser();
                  log(user!.email.toString());
                  log(user.userName.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MilkDetailsScreen(
                        email: user.email!,
                        isAdmin: user.isAdmin,
                      ),
                    ),
                  );
                },
                image: 'assets/milk.jpg',
                title: "Milk",
                subTitle: 'The Best Milk available in the market',
              ),
              ProductCard(
                callback: () async {
                  UserModel? user = await authProvider.getCurrentUser();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ButterMilkDetailsScreen(
                        email: user!.email!,
                        isAdmin: user.isAdmin,
                      ),
                    ),
                  );
                },
                image: 'assets/butter_milk.jpg',
                title: "Butter Milk",
                subTitle: 'The Best Milk available in the market',
              ),
              ProductCard(
                callback: () async {
                  UserModel? user = await authProvider.getCurrentUser();
                },
                image: 'assets/ghee.jpg',
                title: "Ghee",
                subTitle: 'The Best Milk available in the market',
              ),
              ProductCard(
                callback: () async {
                  UserModel? user = await authProvider.getCurrentUser();
                },
                image: 'assets/curd.jpg',
                title: "Curd",
                subTitle: 'The Best Milk available in the market',
              ),
              ProductCard(
                callback: () async {
                  UserModel? user = await authProvider.getCurrentUser();
                },
                image: 'assets/butter.jpg',
                title: "Butter",
                subTitle: 'The Best Milk available in the market',
              )
            ],
          );
        }),
      ),
    );
  }
}
