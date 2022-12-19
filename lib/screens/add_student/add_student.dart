import 'package:EduInfo/screens/add_student/widget/add_student_widget.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);
  static String routeName = 'AddStudent';
  Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'student')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
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
                    return Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: kOtherColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Container(
                                //   width: 40.w,
                                //   height: 4.h,
                                //   decoration: BoxDecoration(
                                //     color: kSecondaryColor.withOpacity(0.4),
                                //     borderRadius:
                                //         BorderRadius.circular(kDefaultPadding),
                                //   ),
                                //   // child: Center(
                                //   //   child: 
                                //   //   Text(
                                //   //     snapshot.data!.docChanges[index].doc['email'],
                                //   //     style: Theme.of(context).textTheme.caption,
                                //   //   ),
                                //   // ),
                                // ),
                                
                                Text(
                                  snapshot.data!.docChanges[index].doc['email'],
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                // kHalfSizedBox,
                                // AssignmentDetailRow(
                                //   title: ' ',
                                //   statusValue: assignment[index].assignDate,
                                // ),
                                // kHalfSizedBox,
                                // AssignmentDetailRow(
                                //   title: 'Last Date',
                                //   statusValue: assignment[index].lastDate,
                                // ),
                                // kHalfSizedBox,
                                // AssignmentDetailRow(
                                //   title: 'Status',
                                //   statusValue: assignment[index].status,
                                // ),
                                // kHalfSizedBox,
                                // //use condition here to display button
                                // if (assignment[index].status == 'Pending')
                                //   //then show button
                                //   AssignmentButton(
                                //     onPress: () {
                                //       //submit here
                                //     },
                                //     title: 'To be Submitted',
                                //   ),
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
              // child: ListView.builder(
              //     padding: EdgeInsets.all(kDefaultPadding),
              //     itemCount: assignment.length,
              //     itemBuilder: (context, int index) {
              //       return Container(
              //         margin: EdgeInsets.only(bottom: kDefaultPadding),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(kDefaultPadding),
              //               decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(kDefaultPadding),
              //                 color: kOtherColor,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: kTextLightColor,
              //                     blurRadius: 2.0,
              //                   ),
              //                 ],
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     width: 40.w,
              //                     height: 4.h,
              //                     decoration: BoxDecoration(
              //                       color: kSecondaryColor.withOpacity(0.4),
              //                       borderRadius:
              //                           BorderRadius.circular(kDefaultPadding),
              //                     ),
              //                     child: Center(
              //                       child: Text(
              //                         assignment[index].senderName,
              //                         style: Theme.of(context).textTheme.caption,
              //                       ),
              //                     ),
              //                   ),
              //                   kHalfSizedBox,
              //                   Text(
              //                     assignment[index].details,
              //                     style: Theme.of(context).textTheme.subtitle2!.copyWith(
              //                       color: kTextBlackColor,
              //                       fontWeight: FontWeight.w900,
              //                     ),
              //                   ),
              //                   kHalfSizedBox,
              //                   AssignmentDetailRow(
              //                     title: ' ',
              //                     statusValue: assignment[index].assignDate,
              //                   ),
              //                   // kHalfSizedBox,
              //                   // AssignmentDetailRow(
              //                   //   title: 'Last Date',
              //                   //   statusValue: assignment[index].lastDate,
              //                   // ),
              //                   // kHalfSizedBox,
              //                   // AssignmentDetailRow(
              //                   //   title: 'Status',
              //                   //   statusValue: assignment[index].status,
              //                   // ),
              //                   // kHalfSizedBox,
              //                   // //use condition here to display button
              //                   // if (assignment[index].status == 'Pending')
              //                   //   //then show button
              //                   //   AssignmentButton(
              //                   //     onPress: () {
              //                   //       //submit here
              //                   //     },
              //                   //     title: 'To be Submitted',
              //                   //   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                                context, AddStudentUsers.routeName);
              },
              child: Icon(Icons.add),
              ),
            );
  }
}
