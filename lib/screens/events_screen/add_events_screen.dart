import 'dart:io';
import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/components/custom_buttons.dart';
import 'package:EduInfo/components/custom_textfeild.dart';
import 'package:EduInfo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);
  static String routeName = 'AddEventsScreen';

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {

  
  AuthController authController = Get.put(AuthController());

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

  Future uploadEvent() async {
    final eventID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("users")
        .doc(authController.myUser.value.uid)
        .collection("events")
      .doc(eventID).set({
        "eventID": eventID,
        "eventType": defaultEvent,
        "eventName": _eventNameController.text.trim(),
        "eventAddTime": DateTime.now(),
        "eventStatus": defaultstatus,
        "eventDate": _dateController.text.trim(),
      }).whenComplete(() =>
          showSnackBar("Event Added Successfully", Duration(seconds: 2)));
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
                          onTap: () async{await showDatePicker(
                              context: context, 
                              initialDate:DateTime.now(),
                              firstDate:DateTime(1900),
                              lastDate: DateTime (DateTime.now ().year + 5)).then((selectedDate) {
                              if (selectedDate != null) {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                              }
                            });
                            },
                          //  
                        ),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              uploadEvent();
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
