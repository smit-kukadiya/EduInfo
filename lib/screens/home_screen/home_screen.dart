import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/screens/add_parent/add_parent.dart';
import 'package:EduInfo/screens/add_student/add_student.dart';
import 'package:EduInfo/screens/contact_screen/contact%20screen.dart';
import 'package:EduInfo/screens/teacher_screen/teacher_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import '../assignment_screen/assignment_screen.dart';
import '../datesheet_screen/datesheet_screen.dart';
import '../login_screen/login_screen.dart';
import 'package:EduInfo/screens/college_cal_screen/college_cal_screen.dart';
import 'package:EduInfo/screens/gallery_screen/gallery_screen.dart';
import 'package:EduInfo/screens/fee_screen/fee_screen.dart';
import 'package:EduInfo/screens/my_profile/my_profile.dart';
import 'package:EduInfo/screens/events_screen/events_screen.dart';
import 'package:EduInfo/screens/result_screen/result_screen.dart';
import 'package:EduInfo/screens/time_table_screen/time_table_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'widgets/student_data.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);
  static String routeName = 'HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  //late String myEmail;

  AuthController authController = Get.put(AuthController());

  //Document IDs
  late String? firstName;

  @override
  void initState() {
    authController.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => authController.myUser.value.email == null
      ? Center(
        child: CircularProgressIndicator(),
      ) :
      Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            width: 100.w,
            height: authController.myUser.value.wrole == 'teacher' ? 35.h : 25.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //buildProfileTile(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Hi ', style: Theme.of(context).textTheme.subtitle1,
                                ),
                                TextSpan(
                                  text: authController.myUser.value.firstName , style: Theme.of(context).textTheme.subtitle1,
                                )
                              ])
                              )
                            ],
                        ),
                        kHalfSizedBox,
                        StudentClass(studentClass: authController.myUser.value.email.toString()),
                        kHalfSizedBox,
                        //StudentYear(studentYear: '2020-2021'),
                      ],
                    ),
                    kHalfSizedBox,
                    StudentPicture(
                        picAddress: 'assets/images/student_profile.jpeg',
                        onPress: () {
                          // go to profile detail screen here
                          Navigator.pushNamed(
                              context, MyProfileScreen.routeName);
                        }),
                  ],
                ),
                sizedBox,
                Obx(() => authController.myUser.value.wrole != 'teacher' ?
                    Center(
                      child: null,
                    ) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // StudentDataCard(
                    //   onPress: () {
                    //     //go to attendance screen
                    //   },
                    //   title: 'Attendance',
                    //   value: '90.02%',
                    // ),
                    StudentDataCard(
                      onPress: () {
                        //go to fee due screen
                        Navigator.pushNamed(context, AssignmentScreen.routeName);
                      },
                      title: 'Annoucement',
                      value: ' ',
                    ),
                  ],
                ), ),
              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(() => authController.myUser.value.wrole == 'teacher' ?
                    Center(
                      child: null,
                    ) :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(context, FeeScreen.routeName);
                          },
                          icon: 'assets/icons/quiz.svg',
                          title: 'Pay Fees',
                        ),
                        HomeCard(
                          onPress: () {
                            //go to assignment screen here
                            Navigator.pushNamed(
                                context, AssignmentScreen.routeName);
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Announcement',
                        ),
                      ],
                    ), ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, CollegeCalScreen.routeName);
                          },
                          icon: 'assets/icons/holiday.svg',
                          title: 'Academic Calendar',
                        ),
                        Obx(() => authController.myUser.value.wrole == 'parent' ?
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, ContactScreen.routeName);
                          },
                          icon: 'assets/icons/timetable.svg',
                          title: 'Contact Teacher',
                        ) :
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, TimeTableScreen.routeName);
                          },
                          icon: 'assets/icons/timetable.svg',
                          title: 'Time Table',
                        ), ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, ResultScreen.routeName);
                          },
                          icon: 'assets/icons/result.svg',
                          title: 'Result',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, GalleryScreen.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Gallery',
                        ),
                        /*HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, DateSheetScreen.routeName);
                          },
                          icon: 'assets/icons/datesheet.svg',
                          title: 'DateSheet',
                        ),*/
                      ],
                    ),
                    Obx(() => authController.myUser.value.wrole != 'teacher' ?
                    Center(
                      child: null,
                    ) :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, AddStudent.routeName);
                          },
                          icon: 'assets/icons/ask.svg',
                          title: 'Add Student',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, AddParent.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Add Parent',
                        ),
                      ],
                    ),),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/resume.svg',
                          title: 'Leave\nApplication',
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/lock.svg',
                          title: 'Change\nPassword',
                        ),
                      ],
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, EventsScreen.routeName);
                          },
                          icon: 'assets/icons/event.svg',
                          title: 'Events',
                        ),
                        HomeCard(
                          onPress: () {
                            //go to login screen here
                            FirebaseAuth.instance.signOut();
                          },
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
