import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Themes/textThemes.dart';
import '../components.dart/strings.dart';
import '../my_widgets.dart/my_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signInRequired = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // email
          const SizedBox(height: 20),
          SizedBox(
            child: MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(CupertinoIcons.mail_solid),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!emailRexExp.hasMatch(val)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),

          // password
          SizedBox(
            child: MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: obscurePassword,
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(CupertinoIcons.lock_fill),
              onChanged: (val) {
                if (val!.contains(RegExp(r'[A-Z]'))) {
                  setState(() {
                    containsUpperCase = true;
                  });
                } else {
                  setState(() {
                    containsUpperCase = false;
                  });
                }
                if (val.contains(RegExp(r'[a-z]'))) {
                  setState(() {
                    containsLowerCase = true;
                  });
                } else {
                  setState(() {
                    containsLowerCase = false;
                  });
                }
                if (val.contains(RegExp(r'[0-9]'))) {
                  setState(() {
                    containsNumber = true;
                  });
                } else {
                  setState(() {
                    containsNumber = false;
                  });
                }
                if (val.contains(specialCharRexExp)) {
                  setState(() {
                    containsSpecialChar = true;
                  });
                } else {
                  setState(() {
                    containsSpecialChar = false;
                  });
                }
                if (val.length >= 8) {
                  setState(() {
                    contains8Length = true;
                  });
                } else {
                  setState(() {
                    contains8Length = false;
                  });
                }
                return null;
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                    if (obscurePassword) {
                      iconPassword = CupertinoIcons.eye_fill;
                    } else {
                      iconPassword = CupertinoIcons.eye_slash_fill;
                    }
                  });
                },
                icon: Icon(iconPassword),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!passwordRexExp.hasMatch(val)) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 10),
          // password validators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "⚈  1 uppercase",
                    style: TextStyle(
                      color:
                          containsUpperCase
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "⚈  1 lowercase",
                    style: TextStyle(
                      color:
                          containsLowerCase
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "⚈  1 number",
                    style: TextStyle(
                      color:
                          containsNumber
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "⚈  1 special character",
                    style: TextStyle(
                      color:
                          containsSpecialChar
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "⚈  8 minimum character",
                    style: TextStyle(
                      color:
                          contains8Length
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // name
          SizedBox(
            child: MyTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(CupertinoIcons.person_fill),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (val.length > 30) {
                  return 'Name too long';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),

          // sign up button
          !signInRequired
              ? SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // context.read<SignInBloc>().add(
                      //       SignInRequired(
                      //         email: emailController.text,
                      //         password: passwordController.text,
                      //       ),
                      //     );
                    }
                  },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextThemes.headline1.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
