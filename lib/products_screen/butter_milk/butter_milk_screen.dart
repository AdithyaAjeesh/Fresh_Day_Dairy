import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/model/user_model.dart';
import 'package:fresh_day_dairy_project/common/widgets/profile_card.dart';
import 'package:fresh_day_dairy_project/products_screen/butter_milk/butter_milk_details_screen.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/product_controller.dart';
import 'package:provider/provider.dart';

class ButterMilkScreen extends StatelessWidget {
  const ButterMilkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final provider = Provider.of<ProductController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Butter Milk',
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
        centerTitle: false,
        backgroundColor: theme.surface,
      ),
      backgroundColor: theme.secondary,
      body: Center(
        child: StreamBuilder<List<UserModel>>(
          stream: provider.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Users available'));
            }
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ProfileCard(
                  title: user.userName.toString(),
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ButterMilkDetailsScreen(
                        isAdmin: true,
                        email: user.email.toString(),
                      ),
                    ));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
