import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    provider.checkLoggedInFunction(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/MILK 1 2.png',
              fit: BoxFit.cover,
            ),
          ),
          // Positioned(
          //   top: 180,
          //   left: 90,
          //   child: Image.asset(
          //     'assets/Layer_1.png',
          //   ),
          // ),
          Align(
            alignment: const Alignment(0, -0.5), // Center the image
            child: Image.asset(
              'assets/Layer_1.png',
            ),
          ),
        ],
      ),
    );
  }
}
