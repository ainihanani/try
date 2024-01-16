import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_apps/firebase_options.dart';
import 'package:learn_apps/pages/login_page.dart';
import 'package:learn_apps/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return const AuthChecker();
        },
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Check the authentication state
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the authentication state
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Show an error message if there is an error
          return Text('Error: ${snapshot.error}');
        } else {
          // Check if the user is logged in
          final bool userLoggedIn = snapshot.hasData;

          if (userLoggedIn) {
            // If user is logged in, navigate to HomePage
            return HomePage(updateUserProfile: () {});
          } else {
            // If user is not logged in, navigate to LoginPage
            return LoginPage(updateUserProfile: () {});
          }
        }
      },
    );
  }
}
