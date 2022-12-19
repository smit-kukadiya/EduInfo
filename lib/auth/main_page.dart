import 'package:EduInfo/auth/auth_page.dart';
// import 'package:EduInfo/desicion_screen/desicion_secreen.dart';
// import 'package:EduInfo/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen/home_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static String routeName = 'MainPage';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return AuthPage();
            }
          },
        ),
      );
  }
}