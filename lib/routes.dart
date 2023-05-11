//import 'package:EduInfo/auth/main_page.dart';
//import 'package:EduInfo/screens/login_screen/login_screen.dart';
import 'package:EduInfo/screens/add_parent/add_parent.dart';
import 'package:EduInfo/screens/add_parent/widget/add_parent_widget.dart';
import 'package:EduInfo/screens/add_student/add_student.dart';
import 'package:EduInfo/screens/add_student/widget/add_student_widget.dart';
import 'package:EduInfo/screens/contact_screen/contact%20screen.dart';
import 'package:EduInfo/screens/events_screen/add_events_screen.dart';
import 'package:EduInfo/screens/my_profile/my_profile_setting/my_profile_setting.dart';
import 'package:EduInfo/screens/splash_screen/splash_screen.dart';
import 'package:EduInfo/screens/college_cal_screen/college_cal_screen.dart';
import 'package:EduInfo/screens/gallery_screen/gallery_screen.dart';
import 'package:EduInfo/screens/teacher_screen/teacher_screen.dart';
import 'package:EduInfo/screens/time_table_screen/time_table_screen.dart';
import 'package:EduInfo/screens/result_screen/result_screen.dart';
import 'package:EduInfo/screens/events_screen/events_screen.dart';
import 'package:EduInfo/screens/assignment_screen/announcement_screen.dart';
import 'package:EduInfo/screens/assignment_screen/announcement_demo_screen.dart';
import 'screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:EduInfo/auth/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/fee_screen/fee_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/my_profile/my_profile.dart';



Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  MainPage.routeName: (context) => MainPage(),
  //LoginScreen.routeName: (context) => LoginScreen(showSignUpScreen: null),
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
  AddStudent.routeName: (context) => AddStudent(),
  AddStudentUsers.routeName: (context) => AddStudentUsers(),
  AddParent.routeName: (context) => AddParent(),
  AddParentUsers.routeName: (context) => AddParentUsers(),
  TeacherScreen.routeName: (context) => TeacherScreen(),
  ContactScreen.routeName: (context) => ContactScreen(),
  MyProfileSetting.routeName: (context) => MyProfileSetting(),
  AddEventsScreen.routeName: (context) => AddEventsScreen(),
  AnnouncementScreen.routeName: (context) => AnnouncementScreen(),
  AnnouncementDemoScreen.routeName: (context) => AnnouncementDemoScreen(),
};
