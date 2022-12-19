import 'package:EduInfo/auth/auth_page.dart';
import 'package:EduInfo/auth/main_page.dart';
import 'package:EduInfo/components/custom_buttons.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/add_parent/add_parent.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddParentUsers extends StatelessWidget {
  AddParentUsers({Key? key}) : super(key: key);
  static String routeName = 'AddParentUsers';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late FirebaseAuth mAuth1;
  
  final _formKey = GlobalKey<FormState>();
  
  final teacher = FirebaseAuth.instance.currentUser!.uid.toString();
  String? parentUID;

  Future addingParent() async {
      FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(), password: _passwordController.text.trim());
      parentUID = await FirebaseAuth.instanceFor(app: app).currentUser!.uid;
      await FirebaseFirestore.instanceFor(app: app).collection('users').doc(parentUID).set({
        'email': _emailController.text.trim(),
        'role': 'parent',
        'tuid': teacher,
        'uid': parentUID,
      });
      
      app.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding New Parent', style: TextStyle(color: kTextWhiteColor),),
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
                              addingParent();
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