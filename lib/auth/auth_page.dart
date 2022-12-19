import 'package:EduInfo/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../screens/sign_up_screen/sign_up_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //intially, show the login page
  bool showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(showSignUpScreen: toggleScreens);
    } else {
      return SignUpScreen(showLoginScreen: toggleScreens,); 
    }
  }
}