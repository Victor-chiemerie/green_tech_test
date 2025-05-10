import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_tech_test/Presentation/Authentication/auth_screen.dart';
import 'package:green_tech_test/Presentation/home_screen.dart';
import 'package:green_tech_test/firebase_options.dart';

import 'Logic/cubits.dart';
import 'Repository/firebase_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(myFirebaseRepository: FirebaseRepository()),
        ),
        BlocProvider(
          create:
              (_) => MyUserCubit(myFirebaseRepository: FirebaseRepository()),
        ),
        BlocProvider(
          create:
              (_) => SignInCubit(myFirebaseRepository: FirebaseRepository()),
        ),
        BlocProvider(
          create:
              (_) => SignUpCubit(myFirebaseRepository: FirebaseRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Tech Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              BlocProvider.of<MyUserCubit>(
                context,
              ).getUser(context.read<AuthCubit>().state.user?.email ?? '');
            }
          },
          builder: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
