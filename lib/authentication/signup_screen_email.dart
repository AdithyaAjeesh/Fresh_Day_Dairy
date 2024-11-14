import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/common/widgets/custom_textfields.dart';
import 'package:provider/provider.dart';

class SignupScreenEmail extends StatelessWidget {
  const SignupScreenEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<AuthController>(builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(height: 120),
                Text(
                  'Sign up',
                  style: TextStyle(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextfields(
                        controller: provider.userNameController,
                        labelText: 'User Name',
                      ),
                      const SizedBox(height: 30),
                      CustomTextfields(
                        controller: provider.emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 30),
                      CustomTextfields(
                        controller: provider.passWordController,
                        labelText: 'Password',
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width / 2, 45),
                        ),
                        onPressed: () {
                          provider.signupWithEmailAndPassword(context);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: theme.surface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an Account'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => SignupScreenEmail(),
                              ));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 100),
                      Column(
                        children: [
                          const Text(
                              'By creating an account you are agreeing to our'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Terms',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primary,
                                  ),
                                ),
                              ),
                              const Text("and"),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Condtions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primary,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
