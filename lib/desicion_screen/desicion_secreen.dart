import 'package:EduInfo/model/users_model/users_model.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'model.dart';
// import 'student.dart';
// import 'teacher.dart';

class DesicionScreen extends StatefulWidget {
  @override
  _DesicionScreenState createState() => _DesicionScreenState();
}

class _DesicionScreenState extends State<DesicionScreen> {
  _DesicionScreenState();
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  UsersModel loggedInUser = UsersModel();
  var wrole;
  var emaill;
  var id;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UsersModel.fromJson(value.data()!);
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        wrole = loggedInUser.wrole.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    if (wrole == 'Student') {
      return HomeScreen(
        //id: id,
      );
    } else {
      return HomeScreen(
        //id: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}