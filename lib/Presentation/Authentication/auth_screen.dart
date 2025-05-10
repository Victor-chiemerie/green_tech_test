import 'package:flutter/material.dart';
import 'package:green_tech_test/Presentation/Authentication/signup_screen.dart';
import '../Themes/textThemes.dart';
import 'signin_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            return SizedBox(
              height: height,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.08),
                    child: Text(
                      'Welcome Back!',
                      style: TextThemes.headline1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  TabBar(
                    controller: tabController,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text('Sign In', style: TextThemes.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text('Sign Up', style: TextThemes.text),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Sign In Tab
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: width * 0.1,
                              right: width * 0.1,
                            ),
                            alignment: Alignment.center,
                            width: width * 0.8,
                            padding: EdgeInsets.only(bottom: 20),
                            child: Center(child: SigninScreen()),
                          ),
                        ),
                        // Sign Up Tab
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: width * 0.1,
                              right: width * 0.1,
                            ),
                            alignment: Alignment.center,
                            width: width * 0.8,
                            padding: EdgeInsets.only(bottom: 20),
                            child: Center(child: SignupScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
