import 'package:firebase_auth/firebase_auth.dart';
import '../../components/custom_buttons.dart';
import '../../constants.dart';
import '../home_screen/home_screen.dart';
import '../forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  final VoidCallback showSignUpScreen;
  const LoginScreen({Key? key, required this.showSignUpScreen}) : super(key: key);
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  // List<String> users = ['Student', 'Teacher', 'Parent'];
  // String? defaultUser = 'Student';

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim(),
        );
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: Text('No user found for that email.'),
            );
          },);
        } else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: Text('Wrong password provided for that user.'),
            );
          },);
        }
    }
  }

  //changes current state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                      Text('Welcome',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Sign in to continue',
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
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          title: 'SIGN IN',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        sizedBox,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ForgotPasswordScreen();
                                },),);
                              },
                              child: Text(
                                'Forgot Password',
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
                          sizedBox,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: widget.showSignUpScreen,
                              child: Text(
                                'Sign Up for Teachers',
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
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 8) {
          return 'Must be more than 7 characters';
        }
      },
    );
  }
}
