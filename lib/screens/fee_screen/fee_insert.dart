import 'dart:io';

import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/fee_screen/widgets/fee_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FeeInsertScreen extends StatefulWidget {
  const FeeInsertScreen({Key? key}) : super(key: key);
  static String routeName = 'FeeInsertScreen';

  @override
  State<FeeInsertScreen> createState() => _FeeInsertScreenState();
}

class _FeeInsertScreenState extends State<FeeInsertScreen> {

  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //app bar theme for tablet
      appBar: AppBar(
        title: Text('Fee Insert Image', style: TextStyle(color: kTextWhiteColor),),
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
                        Obx(() => authController.myUser.value.wrole == 'teacher' ?
                          const Center(
                          child: Text('Hello'),
                        ) : 
                        GestureDetector(
                          onTap: (){
                            getImage(ImageSource.gallery);
                          },
                          child: selectedImage == null ? 
                        
                          Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(0xffD6D6D6)),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ): 
                          Container(
                            height: size.height / 2.5,
                            width: size.width,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.fill),
                                shape: BoxShape.rectangle,
                                color: Color(0xffD6D6D6)),
                          ),
            ),
                        ), 
                        sizedBox,
                        sizedBox,
                        FeeButton(
                              title: 'Upload Payment Image',
                              iconData: 
                                // fee[index].btnStatus == 'COMPLETE'
                                //     ? Icons.done
                                //     : 
                                      Icons.arrow_forward_outlined,
                              onPress: () {
                                if(!_formKey.currentState!.validate()) return;
              
                                authController.isPaymentUploading(true);

                                authController.storePaymentImage(selectedImage, url: authController.myUser.value.paymentImage??"");
                              }),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}