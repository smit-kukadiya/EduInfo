import 'package:new_eduinfo/screens/login_screen/login_screen.dart';
import 'package:new_eduinfo/screens/splash_screen/splash_screen.dart';
import 'package:new_eduinfo/screens/college_cal_screen/college_cal_screen.dart';
import 'package:new_eduinfo/screens/gallery_screen/gallery_screen.dart';
import 'package:new_eduinfo/screens/time_table_screen/time_table_screen.dart';
import 'package:new_eduinfo/screens/result_screen/result_screen.dart';
import 'package:new_eduinfo/screens/events_screen/events_screen.dart';
import 'screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/fee_screen/fee_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/my_profile/my_profile.dart';

Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyProfileScreen.routeName: (context) => MyProfileScreen(),
  FeeScreen.routeName: (context) => FeeScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CollegeCalScreen.routeName: (context) => CollegeCalScreen(),
  GalleryScreen.routeName: (context) => GalleryScreen(),
  TimeTableScreen.routeName: (context) => TimeTableScreen(),
  EventsScreen.routeName: (context) => EventsScreen(),
  ResultScreen.routeName: (context) => ResultScreen(),
};
