import 'dart:io';
import 'package:EduInfo/auth/auth_page.dart';
import 'package:EduInfo/auth/main_page.dart';
import 'package:EduInfo/components/custom_buttons.dart';
import 'package:EduInfo/components/custom_textfeild.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/add_parent/add_parent.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);
  static String routeName = 'AddEventsScreen';

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {

  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  //late FirebaseAuth mAuth1;
  
  final _formKey = GlobalKey<FormState>();

  List<String> event = ['Event', 'Technical', 'Non-Technical'];
  String? defaultEvent = 'Event';
  List<String> status = ['Status', 'Coming Soon', 'Pending', 'Completed'];
  String? defaultstatus = 'Status';
  
  //final teacher = FirebaseAuth.instance.currentUser!.uid.toString();
  //String? parentUID;

  // Future addingParent() async {
  //     FirebaseApp app = await Firebase.initializeApp(
  //       name: 'secondary', options: Firebase.app().options);
  //     await FirebaseAuth.instanceFor(app: app)
  //       .createUserWithEmailAndPassword(
  //           email: _emailController.text.trim(), password: _passwordController.text.trim());
  //     parentUID = FirebaseAuth.instanceFor(app: app).currentUser!.uid;
  //     await FirebaseFirestore.instance.collection('users').doc(parentUID).set({
  //       'email': _emailController.text.trim(),
  //       'role': 'parent',
  //       'tuid': teacher,
  //       'uid': parentUID,
  //     });

  //     await FirebaseFirestore.instance.collection('users').doc(teacher).update({
  //                 'parents': FieldValue.arrayUnion([parentUID]),
  //     });
      
  //     app.delete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding New Event', style: TextStyle(color: kTextWhiteColor),),
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
                        //dropdownButton(users, defaultUser, (item) => setState(() => defaultUser = item)),
                        DropdownButton<String>(
                          isExpanded: true,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: kPrimaryColor, fontSize: 14),
                          dropdownColor: kTextWhiteColor,
                          focusColor: Colors.black,
                          value: defaultEvent,
                            items: event
                              .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item)
                            ))
                              .toList(),
                            onChanged: (item) => setState(() => defaultEvent = item),
                        ),
                        sizedBox,
                        name(_eventNameController, "Event name"),
                        sizedBox,
                        DropdownButton<String>(
                          isExpanded: true,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: kPrimaryColor, fontSize: 14),
                          dropdownColor: kTextWhiteColor,
                          focusColor: Colors.black,
                          value: defaultstatus,
                            items: status
                              .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item)
                            ))
                              .toList(),
                            onChanged: (item) => setState(() => defaultstatus = item),
                        ),
                        sizedBox,
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          style: kInputTextStyle,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            floatingLabelBehavior: FloatingLabelBehavior.always,),
                          //border: OutlineInputBorder(),
                          //labelText: 'FironSaved: (date) {
                          //    String? newDate = date;
                          //  },st Name',
                          // contentPadding:
                          //     EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 8.0)
                          onTap: () async{await showDatePicker(
                              context: context, 
                              initialDate:DateTime.now(),
                              firstDate:DateTime(1900),
                              lastDate: DateTime.now()).then((selectedDate) {
                              if (selectedDate != null) {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                              }
                            });
                            // if(newDate == null) return;
                            // setState(() => date = newDate);
                            },
                          
                          //  
                        ),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              //addingParent();
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
}
