import 'package:EduInfo/constants.dart';
import 'package:flutter/material.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({Key? key}) : super(key: key);
  static String routeName = 'TeacherScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement', style: TextStyle(color: kTextWhiteColor),),
      ),
    );
  }
}