// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/splash_screen.dart';
import 'package:fresh_day_dairy_project/common/controller/bottom_nav_controller.dart';
import 'package:fresh_day_dairy_project/common/themes/lightmode_theme.dart';
import 'package:fresh_day_dairy_project/firebase_options.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/butter_milk_product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/butter_product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/curd_product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/ghee_product_controller.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/milk_product_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MilkProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ButterMilkProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GheeProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurdProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ButterProductController(),
        ),
      ],
      child: MaterialApp(
        // home: const MilkScreen(),
        // home: SignupScreenEmail(),
        home: const SplashScreen(),
        // home: const BottomNavWidget(),
        // home: DeleveryBoysScreen(),
        // home: SettingScreen(),
        // home: const NotificationScreen(),
        // home: const ProfileScreen(),
        debugShowCheckedModeBanner: false,
        theme: lightModeTheme,
      ),
    );
  }
}
