import 'package:EduInfo/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'data/assignment_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/assignment_widgets.dart';



class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {

  final TextEditingController _message = TextEditingController();

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: getSubListView(),
            ),
          ),
          Obx(() => authController.myUser.value.wrole != 'teacher' ?
                    Center(
                      child: null,
                    ) :
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: SizerUtil.deviceType == DeviceType.tablet ? 8.h : 7.h,
              width: 100.w,
              // decoration: BoxDecoration(
              //   color: kTextWhiteColor,
              //   borderRadius: kTopBorderRadius, 
              // ),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      print(_message.text.trim());
                      assignment.insert(0,AssignmentData('Prof. '+authController.myUser.value.firstName.toString() + ' ' + authController.myUser.value.lastName.toString(), _message.text.trim(), DateFormat('yyyy-MM-dd').format(DateTime.now())));
                      _message.text = '';
                      setState(() {
                        getSubListView();
                      });
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  ListView getSubListView() {
    return ListView.builder(
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: assignment.length,
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
                                    child: Text(
                                      assignment[index].senderName,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Text(
                                  assignment[index].details,
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: ' ',
                                  statusValue: assignment[index].assignDate,
                                ),
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
                  });
  }

}
