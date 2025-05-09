import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Themes/textThemes.dart';
import '../components.dart/strings.dart';
import '../my_widgets.dart/my_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signInRequired = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // email
          SizedBox(
            child: MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(CupertinoIcons.mail_solid),
              errorMsg: _errorMsg,
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
              errorMsg: _errorMsg,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!passwordRexExp.hasMatch(val)) {
                  return 'Please enter a valid password';
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
            ),
          ),

          const SizedBox(height: 20),

          // sign in button
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
                      'Sign In',
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
