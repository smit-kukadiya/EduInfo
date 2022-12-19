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

class AddStudentUsers extends StatelessWidget {
  AddStudentUsers({Key? key}) : super(key: key);
  static String routeName = 'AddStudentUsers';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late FirebaseAuth mAuth1;
  
  final _formKey = GlobalKey<FormState>();
  
  final teacher = FirebaseAuth.instance.currentUser!.uid.toString();
  String? studentUID;

  Future addingStudent() async {
      FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(), password: _passwordController.text.trim());
      studentUID = await FirebaseAuth.instanceFor(app: app).currentUser!.uid;
      await FirebaseFirestore.instanceFor(app: app).collection('users').doc(studentUID).set({
        'email': _emailController.text.trim(),
        'role': 'student',
        'tuid': teacher,
        'uid': studentUID,
      });
      
      app.delete();
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
                              Navigator.pushNamed(
                                context, MainPage.routeName);
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
        // suffixIcon: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       _passwordVisible = !_passwordVisible;
        //     });
        //   },
        //   icon: Icon(
        //     _passwordVisible
        //         ? Icons.visibility_off_outlined
        //         : Icons.visibility_off_outlined,
        //   ),
        //   iconSize: kDefaultPadding,
        // ),
      ),
      validator: (value) {
        if (value!.length < 8) {
          return 'Must be more than 7 characters';
        }
      },
    );
  }

}
