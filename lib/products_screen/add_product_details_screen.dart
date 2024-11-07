import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/common/widgets/custom_textfields.dart';
import 'package:fresh_day_dairy_project/products_screen/controller/product_controller.dart';
import 'package:provider/provider.dart';

class AddProductDetailsScreen extends StatelessWidget {
  final String email;
  final String taskCatagory;
  const AddProductDetailsScreen({
    super.key,
    required this.email,
    required this.taskCatagory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Details',
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
      backgroundColor: theme.surface,
      body: Center(
        child: Consumer<ProductController>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CustomTextfields(
                  controller: provider.dateController,
                  labelText: 'Enter Date',
                ),
                const SizedBox(height: 20),
                CustomTextfields(
                  controller: provider.amountController,
                  labelText: 'Enter Amount',
                ),
                const SizedBox(height: 20),
                CustomTextfields(
                  controller: provider.quantityController,
                  labelText: 'Enter Quantity',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    provider.addDailyTask(email, taskCatagory, context);
                  },
                  child: Text(
                    'Add +',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.surface,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
