import 'package:EduInfo/auth/main_page.dart';
import 'package:EduInfo/screens/splash_screen/splash_screen.dart';

import 'routes.dart';
//import 'screens/splash_screen/splash_screen.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EduInfo',
        theme: CustomTheme().baseTheme,
        //initial route is splash screen
        //mean first screen
        home: SplashScreen(),
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}
