import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/common/widgets/profile_card.dart';
import 'package:fresh_day_dairy_project/settings/payment_screen.dart';
import 'package:fresh_day_dairy_project/settings/setting_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: theme.tertiary,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.surface,
      ),
      body: Center(
        child: Consumer<AuthController>(builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                UserModel? user = snapshot.data;
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 120,
                            width: 110,
                            decoration: BoxDecoration(
                              color: theme.onPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset('assets/Ellipse 19.png')),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user!.userName!.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.tertiary,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              user.email!.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.tertiary,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    ProfileCard(
                      title: "Details",
                      ontap: () {},
                    ),
                    ProfileCard(
                      title: "Payment",
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PaymentScreen(),
                        ));
                      },
                    ),
                    ProfileCard(
                      title: "Setting",
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ));
                      },
                    ),
                    ProfileCard(
                      title: "Privacy and Policy",
                      ontap: () {},
                    ),
                    ProfileCard(
                      title: "Location",
                      ontap: () {},
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.5, 45),
                      ),
                      onPressed: () {
                        provider.logoutFunction(context);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: theme.surface,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }),
      ),
    );
  }
}
