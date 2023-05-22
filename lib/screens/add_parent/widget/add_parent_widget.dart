import 'package:EduInfo/auth/auth_controller.dart';
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
import 'package:get/get.dart';

class AddParentUsers extends StatefulWidget {
  AddParentUsers({Key? key}) : super(key: key);
  static String routeName = 'AddParentUsers';

  @override
  State<AddParentUsers> createState() => _AddParentUsersState();
}

class _AddParentUsersState extends State<AddParentUsers> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  List membersDefaultList = [];

  List membersParentList = [];

  AuthController authController = Get.put(AuthController());

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
      parentUID = FirebaseAuth.instanceFor(app: app).currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(parentUID).set({
        'email': _emailController.text.trim(),
        'role': 'parent',
        'tuid': teacher,
        'uid': parentUID,
        'first name': '',
        'payment status': "",
        'payment image': '',
      });

      await FirebaseFirestore.instance.collection('users').doc(teacher).update({
                  'parents': FieldValue.arrayUnion([parentUID]),
      });

      membersDefaultList.add({
          "first name": null,
          "email": _emailController.text.trim(),
          "uid": parentUID,
          "isAdmin": false,
        });
      membersParentList.add({
          "first name": null,
          "email": _emailController.text.trim(),
          "uid": parentUID,
          "isAdmin": false,
        });
        
      final groupDefault = authController.myUser.value.groupDefault;
      final groupParent = authController.myUser.value.groupParent;

      final membersDefault = await FirebaseFirestore.instance.collection('groups').doc(groupDefault).get().then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
      final membersParent = await FirebaseFirestore.instance.collection('groups').doc(groupParent).get().then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>); 
      
      membersDefaultList.addAll(membersDefault['members']);
      membersParentList.addAll(membersParent['members']);

      await FirebaseFirestore.instance.collection('groups').doc(groupDefault).update({
      "members": membersDefaultList,
      });
      await FirebaseFirestore.instance.collection('groups').doc(groupParent).update({
      "members": membersParentList,
      });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(parentUID)
        .collection('groups')
        .doc(groupDefault)
        .set({"name": 'Default', "id": groupDefault});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(parentUID)
        .collection('groups')
        .doc(groupParent)
        .set({"name": 'Parents', "id": groupParent});
      
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
