import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/common/widgets/profile_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
              title: "Account",
              ontap: () {},
            ),
            ProfileCard(
              title: "Notifications",
              ontap: () {},
            ),
            ProfileCard(
              title: "Payment",
              ontap: () {},
            ),
            ProfileCard(
              title: "Privacy and Policy",
              ontap: () {},
            ),
            ProfileCard(
              title: "About",
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
