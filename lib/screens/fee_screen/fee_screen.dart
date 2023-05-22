import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/fee_screen/fee_insert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/fee_data.dart';
import 'widgets/fee_widgets.dart';

class FeeScreen extends StatelessWidget {
  FeeScreen({Key? key}) : super(key: key);
  static String routeName = 'FeeScreen';

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
        title: Text('Pay Fee', style: TextStyle(color: kTextWhiteColor),),
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
      return Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(kDefaultPadding),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // FeeDetailRow(
                                //   title: 'Receipt No',
                                //   statusValue: fee[index].receiptNo,
                                // ),
                                // SizedBox(
                                //   height: kDefaultPadding,
                                //   child: Divider(
                                //     thickness: 1.0,
                                //   ),
                                // ),
                                FeeDetailRow(
                                  title: 'Account No.',
                                  statusValue: snapshot.data!.docChanges[index].doc['account no'],
                                ),
                                sizedBox,
                                FeeDetailRow(
                                  title: 'IFSC Code',
                                  statusValue: snapshot.data!.docChanges[index].doc['ifsc code'],
                                ),
                                sizedBox,
                                FeeDetailRow(
                                  title: 'Recipient name',
                                  statusValue: snapshot.data!.docChanges[index].doc['recipient name'],
                                ),
                                sizedBox,
                                SizedBox(
                                  height: kDefaultPadding,
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),
                                // FeeDetailRow(
                                //   title: 'Total Amount',
                                //   statusValue: fee[index].totalAmount,
                                // ),
                              ],
                            ),
                          ),
                          FeeButton(
                              title: 'Pay',
                              iconData: 
                                authController.myUser.value.paymentStatus == 'submitted'
                                    ? Icons.done
                                    : 
                                      Icons.arrow_forward_outlined,
                              onPress: () {
                                authController.myUser.value.paymentStatus == 'submitted'
                                    ? null
                                    : 
                                       Navigator.pushNamed(context, FeeInsertScreen.routeName);
                                     
                                   })
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      );
        }
      ),
    );
  }
}