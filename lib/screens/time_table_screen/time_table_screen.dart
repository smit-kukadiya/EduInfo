import 'dart:io';

import 'package:EduInfo/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:photo_view/photo_view_gallery.dart';

final imageList = [
    'assets/images/timetable.jpg',
  ];

class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({Key? key}) : super(key: key);
  static String routeName = 'TimeTableScreen';

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
        title: Text('Time Table', style: TextStyle(color: kTextWhiteColor),),
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
                   PhotoView(
                        basePosition: Alignment.center,
                        imageProvider: AssetImage(imageList[0]),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                    gaplessPlayback: false,
                    customSize: MediaQuery.of(context).size,
                    backgroundDecoration: BoxDecoration(
                      color: kOtherColor,
                    ),
                  ),
                ),  
          ),
        ],
      ),
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
