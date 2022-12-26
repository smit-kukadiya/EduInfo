import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/screens/add_parent/widget/add_parent_widget.dart';
import 'package:EduInfo/screens/assignment_screen/widgets/assignment_widgets.dart';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);
  static String routeName = 'ContactScreen';

  AuthController authController = Get.put(AuthController());

  Query getData(){
    return FirebaseFirestore.instance.collection('users')
      .where("uid", isEqualTo: authController.myUser.value.tuid.toString())
      .where('role', isEqualTo: 'teacher');
  }

  Stream<QuerySnapshot> get flashCardWords {
    return getData().snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: StreamBuilder(
        stream: flashCardWords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor.withOpacity(0.4),
                                    borderRadius:
                                        BorderRadius.circular(kDefaultPadding),
                                  ),
                                  child: Center(
                                    child: 
                                    Text(
                                      "Prof. "+snapshot.data!.docChanges[index].doc['first name']+ " "+snapshot.data!.docChanges[index].doc['last name'],
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Text(
                                  snapshot.data!.docChanges[index].doc['email'],
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Email',
                                  statusValue: snapshot.data!.docChanges[index].doc['email'].toString(),
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Phone number',
                                  statusValue: snapshot.data!.docChanges[index].doc['mobile'].toString(),
                                ),
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
          
            );
  }
}
