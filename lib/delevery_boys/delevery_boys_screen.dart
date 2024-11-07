import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/common/widgets/profile_card.dart';

class DeleveryBoysScreen extends StatelessWidget {
  const DeleveryBoysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Boys',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: theme.tertiary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.tertiary,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.surface,
      ),
      backgroundColor: theme.secondary,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ProfileCard(
              title: "Wassem",
              ontap: () {},
            ),
            ProfileCard(
              title: "Abdul",
              ontap: () {},
            ),
            ProfileCard(
              title: "Sharif",
              ontap: () {},
            ),
            ProfileCard(
              title: "Aswin",
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
