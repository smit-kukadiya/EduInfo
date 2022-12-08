import '../../components/custom_buttons.dart';
import '../../constants.dart';
import '../login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   static String routeName = 'ForgotPasswordScreen';
//
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   //validate our form now
//   final _formKey = GlobalKey<FormState>();
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static String routeName = 'ForgotPasswordScreen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
        ),
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
                      Text('Forgot Password',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1),
                      // Text('Sign in to continue',
                      //     style: Theme
                      //         .of(context)
                      //         .textTheme
                      //         .subtitle2),
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
                   //key: _formKey,
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         sizedBox,
                         buildEmailField(),
                         sizedBox,
                         DefaultButton(
                           onPress: () {
                              if (/*_formKey.currentState!.validate()*/true) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.routeName, (route) => false);
                              }
                           },
                           title: 'Submit',
                           iconData: Icons.arrow_forward_outlined,
                         ),
            //             sizedBox,
            //             Align(
            //               alignment: Alignment.center,
            //               child: Text(
            //                 'Forgot Password',
            //                 textAlign: TextAlign.end,
            //                 style: Theme
            //                     .of(context)
            //                     .textTheme
            //                     .subtitle2!
            //                     .copyWith(
            //                     color: kPrimaryColor,
            //                     fontWeight: FontWeight.w500),
            //               ),),
            //             sizedBox,
            //             Align(
            //               alignment: Alignment.center,
            //               child: Text(
            //                 'Sign Up',
            //                 textAlign: TextAlign.end,
            //                 style: Theme
            //                     .of(context)
            //                     .textTheme
            //                     .subtitle2!
            //                     .copyWith(
            //                     color: kPrimaryColor,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //             ),
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
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        print(value);
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
}
