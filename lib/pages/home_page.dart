import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_apps/pages/login_page.dart';
import 'package:learn_apps/screens/featured_screen.dart';

class HomePage extends StatelessWidget {
  final void Function() updateUserProfile;

  const HomePage({super.key, required this.updateUserProfile});

  // Function to handle the sign-out
  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context); // Pop the current screen
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildWelcomeHeader(),
                const Text(
                  "Welcome to an exciting adventure into the world of computer components!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'circe',
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Get ready to explore the fascinating hardware that powers your favorite digital experiences.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'circe',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/splash.png"),
                    ),
                  ),
                ),
                _buildColumnButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
                children: <Widget>[
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "WHERE KIDS LOVE LEARNING BASIC COMPUTER COMPONENTS ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              );
  }

  Widget _buildColumnButton(BuildContext context) {
    return Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeaturedScreen(),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                          builder: (context) => LoginPage(updateUserProfile: () {}),
                        ),
                      );
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              );
  }
}
