import 'package:EduInfo/auth/main_page.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/add_student/widget/add_student_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);
  static String routeName = 'AddStudent';

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final teacher = FirebaseAuth.instance.currentUser!.uid.toString();

  // Query getData() {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .where("tuid", isEqualTo: teacher)
  //       .where('role', isEqualTo: 'student');
  // }

  Stream<QuerySnapshot> flashCardWords() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .where("tuid", isEqualTo: teacher)
        .where('role', isEqualTo: 'student').snapshots();
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future acceptPayment(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'payment status': 'paid'});
  }

  Future rejectPayment(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'payment status': 'rejected'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Student',
          style: TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: flashCardWords(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: kOtherColor,
              borderRadius: kTopBorderRadius,
            ),
            child: ListView.builder(
                padding: EdgeInsets.all(kDefaultPadding),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  return Slidable(
                    // startActionPane:
                    //     ActionPane(motion: const BehindMotion(), children: [
                    //   SlidableAction(
                    //     onPressed: (context) => {},
                    //     label: 'Delete',
                    //     icon: Icons.delete,
                    //     backgroundColor: Colors.red,
                    //   ),
                    // ]),
                    endActionPane:
                        ActionPane(motion: const DrawerMotion(), children: [
                      SlidableAction(
                        onPressed: (context) => {
                          acceptPayment(
                              snapshot.data!.docChanges[index].doc['uid']),
                          Navigator.pushNamed(context, MainPage.routeName)
                        },
                        label: 'Accept',
                        icon: Icons.check,
                        backgroundColor: Colors.green,
                      ),
                      SlidableAction(
                        onPressed: (context) => {
                          rejectPayment(
                              snapshot.data!.docChanges[index].doc['uid']),
                          Navigator.pushNamed(context, MainPage.routeName)
                        },
                        label: 'Reject',
                        icon: Icons.close,
                        backgroundColor: Colors.red,
                      )
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                            color: kOtherColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Text(
                                              snapshot.data!.docChanges[index]
                                                  .doc['email'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: kTextBlackColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (snapshot.data!.docChanges[index]
                                              .doc['payment status'] ==
                                          'paid')
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.check_circle_outline))
                                      else if (snapshot.data!.docChanges[index]
                                              .doc['payment status'] ==
                                          'rejected')
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.close_outlined))
                                      else if (snapshot.data!.docChanges[index]
                                              .doc['payment status'] ==
                                          'submitted')
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.circle_outlined)),
                                      IconButton(
                                        onPressed: () {
                                          if (snapshot.data!.docChanges[index]
                                                  .doc['payment image'] !=
                                              '') {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => ShowImage(
                                                  imageUrl: snapshot
                                                      .data!
                                                      .docChanges[index]
                                                      .doc['payment image'],
                                                ),
                                              ),
                                            );
                                          } else {
                                            showSnackBar('No Payment Image',
                                                Duration(seconds: 2));
                                          }
                                        },
                                        icon: Icon(Icons.image),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddStudentUsers.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
