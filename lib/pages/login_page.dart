import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_apps/pages/home_page.dart';
import 'package:learn_apps/pages/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Pass updateUserProfile as a parameter to LoginPage
  final void Function() updateUserProfile;

  LoginPage({super.key, required this.updateUserProfile});

  void _handleLogin(BuildContext context) async {
    const String adminEmail = 'test@domain.com';
    const String adminPassword = '123456';

    if (_emailController.text == adminEmail && _passwordController.text == adminPassword) {
      // Admin Login
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: adminEmail,
          password: adminPassword,
        );
        if (credential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(updateUserProfile: updateUserProfile),
            ),
          );
        }
      } on FirebaseAuthException {
        // Handle admin login errors if any
        String errorMessage = 'Error during admin login.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Regular User Login
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (credential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(updateUserProfile: updateUserProfile),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Error during user login.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        _inputField(label: "Email", controller: _emailController),
                        _inputField(label: "Password", obscureText: true, controller: _passwordController),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          _handleLogin(context); // Call the login method here
                        },
                        color: const Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromARGB(255, 234, 235, 236),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                        },
                        child: const Text(
                          " Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({label, obscureText = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 201, 201),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 221, 214, 214),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
