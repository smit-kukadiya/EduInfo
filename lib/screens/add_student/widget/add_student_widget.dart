import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/auth/auth_page.dart';
import 'package:EduInfo/auth/main_page.dart';
import 'package:EduInfo/components/custom_buttons.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/add_student/add_student.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class AddStudentUsers extends StatefulWidget {
  AddStudentUsers({Key? key}) : super(key: key);
  static String routeName = 'AddStudentUsers';

  @override
  State<AddStudentUsers> createState() => _AddStudentUsersState();
}

class _AddStudentUsersState extends State<AddStudentUsers> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  List membersDefaultList = [];

  List membersStudentList = [];

  AuthController authController = Get.put(AuthController());

  late FirebaseAuth mAuth1;

  final _formKey = GlobalKey<FormState>();

  final teacher = FirebaseAuth.instance.currentUser!.uid.toString();

  late String? studentUID;

  Future addingStudent() async{
      FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(), password: _passwordController.text.trim());


      studentUID = FirebaseAuth.instanceFor(app: app).currentUser!.uid.toString();

      await FirebaseFirestore.instance.collection('users').doc(teacher).update({
                  'students': FieldValue.arrayUnion([studentUID]),
      });

      await FirebaseFirestore.instance.collection('users').doc(studentUID).set({
        'email': _emailController.text.trim(),
        'role': 'student',
        'tuid': teacher,
        'uid': studentUID,
        'first name': '',
        'payment status': "",
        'payment image': '',
      });

      membersDefaultList.add({
          "first name": null,
          "email": _emailController.text.trim(),
          "uid": studentUID,
          "isAdmin": false,
        });
      membersStudentList.add({
          "first name": null,
          "email": _emailController.text.trim(),
          "uid": studentUID,
          "isAdmin": false,
        });
        
      final groupDefault = authController.myUser.value.groupDefault;
      final groupStudent = authController.myUser.value.groupStudent;

      final membersDefault = await FirebaseFirestore.instance.collection('groups').doc(groupDefault).get().then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
      final membersStudent = await FirebaseFirestore.instance.collection('groups').doc(groupStudent).get().then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>); 
      
      membersDefaultList.addAll(membersDefault['members']);
      membersStudentList.addAll(membersStudent['members']);

      await FirebaseFirestore.instance.collection('groups').doc(groupDefault).update({
      "members": membersDefaultList,
      });
      await FirebaseFirestore.instance.collection('groups').doc(groupStudent).update({
      "members": membersStudentList,
      });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(studentUID)
        .collection('groups')
        .doc(groupDefault)
        .set({"name": 'Default', "id": groupDefault});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(studentUID)
        .collection('groups')
        .doc(groupStudent)
        .set({"name": 'Students', "id": groupStudent});
    
      app.delete().whenComplete(() =>
          showSnackBar("Student added", Duration(seconds: 2)));
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding New Student', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              addingStudent();
                            }
                          },
                          title: 'INSERT',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                      ],
                    ),
                  ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //print(value);
        //for validation
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value!.length < 8) {
          return 'Must be more than 7 characters';
        }
      },
    );
  }
}
