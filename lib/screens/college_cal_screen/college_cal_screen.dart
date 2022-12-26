import 'dart:io';

import 'package:EduInfo/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

final imageList = [
    'assets/images/acalender.jpg',
  ];

class CollegeCalScreen extends StatelessWidget {
  CollegeCalScreen({Key? key}) : super(key: key);
  static String routeName = 'CollegeCalScreen';

  AuthController authController = Get.put(AuthController());

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      //setState(() {});
    }
  }

  @override
  void initState() {
    authController.getUserInfo();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Calendar', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
             child: Container(
               decoration: BoxDecoration(
                 color: kOtherColor,
                 borderRadius: kTopBorderRadius,
               ),
               child:
                   PhotoViewGallery.builder(
                    itemCount: imageList.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        basePosition: Alignment.center,
                        imageProvider: AssetImage(imageList[index]),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(
                      color: kOtherColor,
                    ),
                  ),
                ),  
          ),
        ],
       //const Center(
          //child: 
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: kOtherColor,
      //           borderRadius: kTopBorderRadius,
      //         ),
      //         child: ListView.builder(
      //             padding: EdgeInsets.all(kDefaultPadding),
      //             //itemCount: assignment.length,
      //             itemBuilder: (context, int index) {
      //               return Container(
      //                 margin: EdgeInsets.only(bottom: kDefaultPadding),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Container(
      //                       padding: EdgeInsets.all(kDefaultPadding),
      //                       decoration: BoxDecoration(
      //                         borderRadius:
      //                             BorderRadius.circular(kDefaultPadding),
      //                         color: kOtherColor,
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: kTextLightColor,
      //                             blurRadius: 2.0,
      //                           ),
      //                         ],
      //                       ),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Container(
      //                             width: 40.w,
      //                             height: 4.h,
      //                             decoration: BoxDecoration(
      //                               color: kSecondaryColor.withOpacity(0.4),
      //                               borderRadius:
      //                                   BorderRadius.circular(kDefaultPadding),
      //                             ),
      //                             child: Center(
      //                               child: Text(
      //                                 assignment[index].subjectName,
      //                                 style: Theme.of(context).textTheme.caption,
      //                               ),
      //                             ),
      //                           ),
      //                           kHalfSizedBox,
      //                           Text(
      //                             assignment[index].topicName,
      //                             style: Theme.of(context).textTheme.subtitle2!.copyWith(
      //                               color: kTextBlackColor,
      //                               fontWeight: FontWeight.w900,
      //                             ),
      //                           ),
      //                           kHalfSizedBox,
      //                           AssignmentDetailRow(
      //                             title: 'Assign Date',
      //                             statusValue: assignment[index].assignDate,
      //                           ),
      //                           kHalfSizedBox,
      //                           AssignmentDetailRow(
      //                             title: 'Last Date',
      //                             statusValue: assignment[index].lastDate,
      //                           ),
      //                           kHalfSizedBox,
      //                           AssignmentDetailRow(
      //                             title: 'Status',
      //                             statusValue: assignment[index].status,
      //                           ),
      //                           kHalfSizedBox,
      //                           //use condition here to display button
      //                           if (assignment[index].status == 'Pending')
      //                             //then show button
      //                             AssignmentButton(
      //                               onPress: () {
      //                                 //submit here
      //                               },
      //                               title: 'To be Submitted',
      //                             ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             }),
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton:  Visibility(visible:authController.myUser.value.wrole == 'teacher',
        child:
        FloatingActionButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Icon(Icons.add),
              )),
    );
  }
}
