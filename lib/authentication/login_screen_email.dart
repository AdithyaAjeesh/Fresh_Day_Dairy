import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/authentication/controller/auth_controller.dart';
import 'package:fresh_day_dairy_project/authentication/signup_screen_email.dart';
import 'package:fresh_day_dairy_project/common/widgets/custom_textfields.dart';
import 'package:provider/provider.dart';

class LoginScreenEmail extends StatelessWidget {
  const LoginScreenEmail({super.key});

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
                  'Login',
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
                        controller: provider.emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 50),
                      CustomTextfields(
                        controller: provider.passWordController,
                        labelText: 'Password',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primary,
                                ),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primary,
                              ),
                            ),
                          )
                        ],
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
                          provider.loginFunction(context);
                        },
                        child: Text(
                          'Login',
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignupScreenEmail(),
                              ));
                            },
                            child: Text(
                              'Sign Up',
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
