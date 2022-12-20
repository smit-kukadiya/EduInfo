import 'package:EduInfo/components/custom_textfeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../components/custom_buttons.dart';
import '../../constants.dart';
import '../login_screen/login_screen.dart';

//late bool _passwordVisible;

class SignUpScreen extends StatefulWidget {
  final VoidCallback showLoginScreen ;
  const SignUpScreen({Key? key, required this.showLoginScreen,}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // List<String> users = ['Student', 'Teacher', 'Parent'];
  // String? defaultUser = 'Student';

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _passwordVisible = true;
  // } 

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
      );

      //add user details
      addUserDetails(_firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        int.parse(_mobileController.text.trim()),
      );
    }
  }

  //String 

  Future addUserDetails(String firstName, String lastName, String email, int mobile) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'mobile': mobile,
      'role': 'teacher',
      'uid': FirebaseAuth.instance.currentUser?.uid.toString(),
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Teacher',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Sign Up to continue',
                          style: Theme.of(context).textTheme.subtitle2),
                      sizedBox,
                    ],
                  ),
                  Image.asset(
                    'assets/images/splash.png',
                    height: 20.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  //reusable radius,
                  borderRadius: kTopBorderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // sizedBox,
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     'Role',
                        //     textAlign: TextAlign.end,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .subtitle2!
                        //         .copyWith(
                        //         color: kPrimaryColor,
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        //
                        // ),
                        // sizedBox,
                        // DropdownButton<String>(
                        //   isExpanded: true,
                        //   iconEnabledColor: Colors.white,
                        //   style: TextStyle(color: kPrimaryColor, fontSize: 14),
                        //   dropdownColor: kTextWhiteColor,
                        //   focusColor: Colors.black,
                        //   value: defaultUser,
                        //     items: users
                        //       .map((item) => DropdownMenuItem<String>(
                        //         value: item,
                        //         child: Text(item)
                        //     ))
                        //       .toList(),
                        //      onChanged: (item) => setState(() => defaultUser = item),
                        // ),
                        sizedBox,
                        rowFirstLastName(_firstNameController, 'First Name',  _lastNameController, 'Last Name'),
                        sizedBox,
                        buildEmailField(_emailController, 'Email'),
                        sizedBox,
                        buildMobileField(_mobileController, 'Mobile Number'),
                        sizedBox,
                        buildPasswordField("Password", _passwordController, true),
                        sizedBox,
                        buildPasswordField("Confirm Password", _confirmPasswordController, true),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                            }
                          },
                          title: 'SIGN UP',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        // sizedBox,
                        // AnotherButton(
                        //   onPress: () {
                        //     Navigator.pushNamedAndRemoveUntil(context,
                        //         ForgotPasswordScreen.routeName, (route) => false);
                        //   },
                        //   //alignment: Alignment.center,
                        //   //child: Text(
                        //     title: 'Forgot Password',
                        //     //iconData: Icons.arrow_forward_outlined,
                        //     //textAlign: TextAlign.end,
                        //     // style: Theme.of(context)
                        //     //     .textTheme
                        //     //     .subtitle2!
                        //     //     .copyWith(
                        //     //         color: kPrimaryColor,
                        //     //         fontWeight: FontWeight.w500),
                        //   ),
                          sizedBox,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: widget.showLoginScreen,
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  //   TextFormField buildEmailField(name, textName) {
  //   return TextFormField(
  //     controller: name,
  //     textAlign: TextAlign.start,
  //     keyboardType: TextInputType.emailAddress,
  //     style: kInputTextStyle,
  //     decoration: InputDecoration(
  //       labelText: textName,
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //     validator: (value) {
  //       print(value);
  //       //for validation
  //       RegExp regExp = new RegExp(emailPattern);
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter some text';
  //         //if it does not matches the pattern, like
  //         //it not contains @
  //       } else if (!regExp.hasMatch(value)) {
  //         return 'Please enter a valid email address';
  //       }
  //     },
  //   );
  // }

  TextFormField buildPasswordField(name, passController, obscure) {
    return TextFormField(
      controller: passController,
      obscureText: obscure,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: name,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       obscure = !obscure;
        //     });
        //   },
        //   icon: Icon(
        //     obscure
        //         ? Icons.visibility_off_outlined
        //         : Icons.visibility_off_outlined,
        //   ),
        //   iconSize: kDefaultPadding,
        // ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Must be more than 5 characters';
        }
      },
    );
  }
}