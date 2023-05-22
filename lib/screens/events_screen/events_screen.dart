import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/screens/events_screen/add_events_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'data/events_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/events_widgets.dart';



class EventsScreen extends StatefulWidget {
  EventsScreen({Key? key}) : super(key: key);
  static String routeName = 'EventsScreen';

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.getUserInfo();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Detail', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(authController.myUser.value.tuid ?? authController.myUser.value.uid)
                      .collection("events")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("something is wrong");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No Images"),
                      );
                    }
              return ListView.builder(
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
                                    child: Text(
                                      snapshot.data!.docs[index]['eventType'],
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Text(
                                  snapshot.data!.docs[index]['eventName'],
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                kHalfSizedBox,
                                EventsDetailRow(
                                  title: 'Date',
                                  statusValue: snapshot.data!.docs[index]['eventDate'],
                                ),
                                // kHalfSizedBox,
                                // EventsDetailRow(
                                //   title: 'Last Date',
                                //   statusValue: assignment[index].lastDate,
                                // ),
                                kHalfSizedBox,
                                EventsDetailRow(
                                  title: 'Status',
                                  statusValue: snapshot.data!.docs[index]['eventStatus'],
                                ),
                                kHalfSizedBox,
                                //use condition here to display button
                                // if (assignment[index].status == 'Pending')
                                //   //then show button
                                //   EventsButton(
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
                      }),
            ),
          ),
        ],
      ),
      floatingActionButton:  Visibility(visible:authController.myUser.value.wrole == 'teacher',
        child:
        FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                                context, AddEventsScreen.routeName);
                },
                child: Icon(Icons.add),
              )),
    );
  }
}
